defmodule ChatClient do
  @chat_server :"chat_server@Evgenijs-MacBook-Pro"
  @name MyChat

  def start do
    connected = Node.connect(@chat_server)
    inform_client_connected(connected)
    connected
  end

  def send_message(msg) do
    :rpc.call(@chat_server, ChatServer, :send_message, [node(), msg])
  end

  def receive_message(client, msg) do
    GenServer.call(@name, {:receive_message, client, msg})
  end

  defp inform_client_connected(false), do: false

  defp inform_client_connected(true) do
    :rpc.call(@chat_server, ChatServer, :client_connected, [node()])
  end
end
