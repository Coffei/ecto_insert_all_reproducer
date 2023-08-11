defmodule InsertAllReproducer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      InsertAllReproducerWeb.Telemetry,
      # Start the Ecto repository
      InsertAllReproducer.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: InsertAllReproducer.PubSub},
      # Start Finch
      {Finch, name: InsertAllReproducer.Finch},
      # Start the Endpoint (http/https)
      InsertAllReproducerWeb.Endpoint
      # Start a worker by calling: InsertAllReproducer.Worker.start_link(arg)
      # {InsertAllReproducer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InsertAllReproducer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InsertAllReproducerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
