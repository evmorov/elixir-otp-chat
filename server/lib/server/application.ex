defmodule Server.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Server.Server, [])
    ]

    options = [
      name: Server.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end
end
