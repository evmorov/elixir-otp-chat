defmodule ChatServer.Server do
  use GenServer

  @name MyServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:send_message, message}, _from, state) do
    {:reply, "Received #{message}", state}
  end
end
