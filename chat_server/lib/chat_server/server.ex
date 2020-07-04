defmodule ChatServer.Server do
  use GenServer

  @name MyServer
  @system_name "System"

  def start_link do
    GenServer.start_link(__MODULE__, %{connected: %{}}, name: @name)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:client_connected, caller, nickname}, state) do
    log_client_connected(caller, nickname)

    inform_clients_about_new_user(caller, nickname)

    state =
      Map.update!(state, :connected, fn connected ->
        Map.put(connected, caller, nickname)
      end)

    {:noreply, state}
  end

  def handle_cast({:new_message, caller, msg}, state) do
    log_new_message(caller, extract_nickname(state, caller), msg)
    GenServer.cast(@name, {:broadcast, caller, msg})

    {:noreply, state}
  end

  def handle_cast({:broadcast, caller, msg}, state) do
    Node.list()
    |> Enum.each(&broadcast(&1, extract_nickname(state, caller), msg))

    {:noreply, state}
  end

  defp inform_clients_about_new_user(caller, nickname) do
    Node.list()
    |> Enum.filter(&(&1 != caller))
    |> Enum.each(&broadcast(&1, @system_name, "#{nickname} entered the chat"))
  end

  defp broadcast(client, nickname, msg) do
    :rpc.call(client, ChatClient, :receive_message, [DateTime.utc_now(), nickname, msg])
  end

  defp extract_nickname(state, client) do
    Map.get(state.connected, client)
  end

  defp log_client_connected(caller, nickname) do
    IO.puts("#{datetime_now()}, client connected: #{caller}, #{nickname}")
  end

  defp log_new_message(caller, nickname, msg) do
    IO.puts("#{datetime_now()}, #{caller}, #{nickname}: #{msg}")
  end

  defp datetime_now do
    DateTime.utc_now() |> DateTime.truncate(:second)
  end
end
