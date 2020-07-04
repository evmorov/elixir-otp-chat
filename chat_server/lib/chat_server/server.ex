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
    IO.puts("Client connected: #{caller}")

    {:noreply, state}
  end

  def handle_cast({:new_message, caller, msg}, state) do
    IO.puts("#{caller}: #{msg}")

    {:noreply, state}
    # {:reply, "You: #{msg}", state}
  end

  def handle_cast({:send_messages_to_clients, caller, msg}, state) do
    Node.list()
    |> Enum.filter(fn node -> node != caller end)
    |> Enum.each(&send_message_to_client(&1, caller, msg))

    {:noreply, state}
  end

  defp send_message_to_client(client, caller, msg) do
    :rpc.call(client, ChatClient, :receive_message, [caller, msg])
  end
end
