defmodule ChatServer.Server do
  use GenServer

  @name MyServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:client_connected, caller}, state) do
    log_client_connected(caller)

    {:noreply, state}
  end

  def handle_cast({:new_message, caller, msg}, state) do
    log_new_message(caller, msg)

    {:noreply, state}
  end

  def handle_cast({:send_messages_to_clients, caller, msg}, state) do
    Node.list() |> Enum.each(&send_message_to_client(&1, caller, msg))

    {:noreply, state}
  end

  defp send_message_to_client(client, caller, msg) do
    :rpc.call(client, ChatClient, :receive_message, [DateTime.utc_now(), caller, msg])
  end

  defp log_client_connected(caller) do
    IO.puts("#{datetime_now()}, client connected: #{caller}")
  end

  defp log_new_message(caller, msg) do
    IO.puts("#{datetime_now()}, #{caller}: #{msg}")
  end

  defp datetime_now do
    DateTime.utc_now() |> DateTime.truncate(:second)
  end
end
