defmodule ChatClient do
  @chat_server :"chat_server@Evgenijs-MacBook-Pro"
  # @chat_server :"chat_server@161.35.157.135"

  @name MyChat

  def start do
    Node.connect(@chat_server)
    |> inform_client_connected()

    ChatClient.Interact.prompt()
  end

  def send_message(msg) do
    :rpc.call(@chat_server, ChatServer, :new_message, [node(), msg])
  end

  def receive_message(date_time_utc, client, msg) do
    GenServer.cast(@name, {:receive_message, date_time_utc, client, msg})
  end

  defp inform_client_connected(false), do: false

  defp inform_client_connected(true) do
    :rpc.call(@chat_server, ChatServer, :client_connected, [node()])
  end
end
