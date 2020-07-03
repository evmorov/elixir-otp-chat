defmodule ChatServer do
  @name MyServer

  def send_message(caller, msg) do
    response = GenServer.call(@name, {:send_message, caller, msg})
    send_message_to_clients(caller, msg)
    response
  end

  def client_connected(caller) do
    GenServer.call(@name, {:client_connected, caller})
  end

  defp send_message_to_clients(caller, msg) do
    Node.list()
    |> Enum.filter(fn node -> node != caller end)
    |> Enum.each(&send_message_to_client(&1, caller, msg))
  end

  defp send_message_to_client(client, caller, msg) do
    :rpc.call(client, ChatClient, :receive_message, [caller, msg])
  end
end
