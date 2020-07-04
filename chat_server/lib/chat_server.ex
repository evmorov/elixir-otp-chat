defmodule ChatServer do
  @name MyServer

  def new_message(caller, msg) do
    response = GenServer.call(@name, {:new_message, caller, msg})
    GenServer.cast(@name, {:send_messages_to_clients, caller, msg})

    response
  end

  def client_connected(caller) do
    GenServer.cast(@name, {:client_connected, caller})
  end
end
