defmodule PhoenixNsq.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(PhoenixNsqWeb.Endpoint, []),
      # Start your own worker by calling: PhoenixNsq.Worker.start_link(arg1, arg2, arg3)
      # worker(PhoenixNsq.Worker, [arg1, arg2, arg3]),
      supervisor(NSQ.Producer.Supervisor, [
        "default-topic",
        %NSQ.Config{
          nsqds: ["127.0.0.1:4150", "127.0.0.1:4151"]
        }
      ])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixNsq.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhoenixNsqWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
