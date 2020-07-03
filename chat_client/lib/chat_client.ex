defmodule ChatClient do
  @chat_server :"chat_server@Evgenijs-MacBook-Pro"

  def send_message(message) do
    :rpc.call(@chat_server, ChatServer, :send_message, [message])
  end
end
