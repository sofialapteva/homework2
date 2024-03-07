defmodule Homework2Test do
  use ExUnit.Case
  doctest Homework2

  test "it responds to a ping with a pong" do
    pid = Homework2.send({:ping, self()})
    assert_receive {:pong, ^pid}
  end

  test "it responds to a different message with an error" do
    pid = Homework2.send({:pong, self()})
    assert_receive {:error, ^pid}
  end
end
