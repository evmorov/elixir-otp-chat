defmodule ElixirOtpChatTest do
  use ExUnit.Case
  doctest ElixirOtpChat

  test "greets the world" do
    assert ElixirOtpChat.hello() == :world
  end
end
