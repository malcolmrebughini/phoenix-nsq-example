defmodule PhoenixNsqWeb.Router do
  use PhoenixNsqWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhoenixNsqWeb do
    pipe_through :api
  end
end
