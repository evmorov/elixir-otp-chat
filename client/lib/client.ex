defmodule Client do
  @server :"server@Evgenijs-MacBook-Pro"

  def send_message(message) do
    :rpc.call(@server, Server, :send_message, [message])
  end
end
