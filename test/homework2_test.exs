defmodule Homework2Test do
  use ExUnit.Case, capture_logs: true
  doctest Homework2

  test "it responds to a ping with a pong" do
    pid = Homework2.send({:ping, self()})
    assert_receive({:pong, ^pid})
  end

  test "it responds to a different message with an error" do
    assert Homework2.send(:wrong_message), "Malformed message"
  end
end
