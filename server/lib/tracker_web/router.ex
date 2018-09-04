defmodule TrackerWeb.Router do
  use TrackerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TrackerWeb do
    pipe_through :api
  end

  scope "/auth", TrackerWeb do
    pipe_through :api

    get "/:provider", AccountController, :request
    get "/:provider/callback", AccountController, :callback
  end
end
