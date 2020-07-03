defmodule ChatServer.Server do
  use GenServer

  @name MyServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:client_connected, caller}, _from, state) do
    IO.puts("Client connected: #{caller}")
    {:noreply, state}
  end

  def handle_call({:send_message, caller, msg}, _from, state) do
    IO.puts("#{caller}: #{msg}")
    {:reply, "You: #{msg}", state}
  end
end
