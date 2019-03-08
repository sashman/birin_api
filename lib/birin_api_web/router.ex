defmodule BirinApiWeb.Router do
  use BirinApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BirinApiWeb do
    pipe_through :api
  end
end
