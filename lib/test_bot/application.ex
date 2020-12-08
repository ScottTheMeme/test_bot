defmodule TestBot.Application do
  use Application

  def start(_type, _args) do
    children = [
      Nosedrum.Storage.ETS,
      TestBot.Consumer
    ]

    options = [strategy: :one_for_one, name: TestBot.Supervisor]
    Supervisor.start_link(children, options)
  end
end
