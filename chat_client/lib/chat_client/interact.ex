defmodule ChatClient.Interact do
  def message_prompt do
    IO.gets("")
    |> check_input()
    |> ChatClient.send_message()

    message_prompt()
  end

  defp check_input({:error, reason}) do
    IO.puts("Chat ended: #{reason}")
    exit(:normal)
  end

  defp check_input(:eof) do
    IO.puts("Something went wrong...")
    exit(:normal)
  end

  defp check_input(input) do
    String.trim(input)
  end
end
