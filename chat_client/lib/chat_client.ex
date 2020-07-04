defmodule ChatClient do
  @chat_server :"chat_server@Evgenijs-MacBook-Pro"

  # @chat_server :"chat_server@161.35.157.135"

  @name MyChat

  def start(nickname: nickname) do
    connect_to_server(nickname)
    ChatClient.Interact.prompt()
  end

  def send_message(msg) do
    :rpc.call(@chat_server, ChatServer, :new_message, [node(), msg])
  end

  def receive_message(date_time_utc, nickname, msg) do
    GenServer.cast(@name, {:receive_message, date_time_utc, nickname, msg})
  end

  defp connect_to_server(nickname) do
    Node.connect(@chat_server) |> send_details(nickname)
  end

  defp send_details(false, _nickname), do: false

  defp send_details(true, nickname) do
    :rpc.call(@chat_server, ChatServer, :client_connected, [node(), nickname])
  end
end
