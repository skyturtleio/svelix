defmodule Svelix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SvelixWeb.Telemetry,
      Svelix.Repo,
      {DNSCluster, query: Application.get_env(:svelix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Svelix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Svelix.Finch},
      # Start a worker by calling: Svelix.Worker.start_link(arg)
      # {Svelix.Worker, arg},
      # Start to serve requests, typically the last entry
      SvelixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Svelix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SvelixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
