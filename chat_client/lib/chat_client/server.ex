defmodule ChatClient.Server do
  use GenServer

  @name MyChat

  def start_link do
    connected = ChatClient.start()
    GenServer.start_link(__MODULE__, %{connected: connected}, name: @name)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:receive_message, client, msg}, _from, state) do
    IO.puts("#{client}: #{msg}")
    {:noreply, state}
  end
end
