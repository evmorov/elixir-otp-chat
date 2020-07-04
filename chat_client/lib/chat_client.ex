defmodule ChatClient do
  @name MyChat

  def start(chat_server: chat_server) do
    Node.connect(chat_server)
    |> start_chat(chat_server)
  end

  def send_message(""), do: false

  def send_message(msg) do
    GenServer.call(@name, :get_chat_server)
    |> :rpc.call(ChatServer, :new_message, [node(), msg])
  end

  def receive_message(date_time_utc, nickname, msg) do
    GenServer.cast(@name, {:receive_message, date_time_utc, nickname, msg})
  end

  defp start_chat(_connected = false, chat_server) do
    IO.puts("Can't connect to #{chat_server}")
  end

  defp start_chat(_connected = true, chat_server) do
    IO.puts("Connected")

    ChatClient.Interact.ask_nickname()
    |> send_details(chat_server)

    GenServer.call(@name, {:set_chat_server, chat_server})

    ChatClient.Interact.message_prompt()
  end

  defp send_details(nickname, chat_server) do
    :rpc.call(chat_server, ChatServer, :client_connected, [node(), nickname])
  end
end
