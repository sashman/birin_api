defmodule BirinApiWeb.Router do
  use BirinApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BirinApiWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    resources "/ring_numbers", RingNumberController, except: [:new, :edit]
  end
end
