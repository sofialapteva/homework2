defmodule Homework2 do
  @moduledoc """
    This module provides a single function `Homework2.send/1`, which spawns a process.
    This process then receives a message passed as an argument to the function.
  """

  @doc """
  Receive a reply from a spawned process:

  ## Examples
      iex> pid = Homework2.send {:ping, self()}
      pid
      iex> assert_receive {:pong, ^pid}
      {:pong, pid}
  """

  @spec send({}) :: pid()
  def send(message) do
    receiver =
      fn recursive_call ->
        fn ->
          receive do
            {:ping, pid} ->
              send(pid, {:pong, self()})
              recursive_call.(recursive_call)

            _match_everything ->
              IO.puts("Malformed message")
              recursive_call.(recursive_call)
          end
        end
      end

    pid =
      Process.spawn(receiver.(receiver), [:link])

    Process.send(pid, message, [])
    pid
  end
end
