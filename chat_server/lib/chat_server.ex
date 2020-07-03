defmodule ChatServer do
  @name MyServer

  def send_message(message) do
    GenServer.call(@name, {:send_message, message})
  end
end
