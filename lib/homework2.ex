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

      iex> pid = Homework2.send {:boom, self()}
      pid
      iex> assert_receive {:error, ^pid}
      {:error, pid}
  """

  @spec send({}) :: pid()
  def send(message) do
    pid =
      Process.spawn(
        fn ->
          receive do
            {:ping, pid} -> send(pid, {:pong, self()})
            {_, pid} -> send(pid, {:error, self()})
          end
        end,
        [:link]
      )

    Process.send(pid, message, [:noconnect])
    pid
  end
end
