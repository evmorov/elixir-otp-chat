defmodule ChatServer.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(ChatServer.Server, [])
    ]

    options = [
      name: ChatServer.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end
end
