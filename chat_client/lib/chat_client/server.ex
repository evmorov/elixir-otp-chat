defmodule ChatClient.Server do
  use GenServer

  @name MyChat

  def start_link do
    GenServer.start_link(__MODULE__, %{chat_server: nil}, name: @name)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:receive_message, date_time_utc, nickname, msg}, state) do
    IO.puts("#{DateTime.truncate(date_time_utc, :second)}, #{nickname}: #{msg}")
    {:noreply, state}
  end

  def handle_call({:set_chat_server, chat_server}, _from, state) do
    {:reply, :ok, Map.put(state, :chat_server, chat_server)}
  end

  def handle_call(:get_chat_server, _from, state) do
    {:reply, Map.get(state, :chat_server), state}
  end
end
