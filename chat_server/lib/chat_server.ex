defmodule ChatServer do
  @name MyServer

  def new_message(caller, msg) do
    GenServer.cast(@name, {:new_message, caller, msg})
    GenServer.cast(@name, {:broadcast, caller, msg})
  end

  def client_connected(caller, nickname) do
    GenServer.cast(@name, {:client_connected, caller, nickname})
  end
end
