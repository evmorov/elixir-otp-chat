defmodule ChatClient.Server do
  use GenServer

  @name MyChat

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:receive_message, date_time_utc, client, msg}, state) do
    IO.puts("#{DateTime.truncate(date_time_utc, :second)}, #{client}: #{msg}")
    {:noreply, state}
  end
end
