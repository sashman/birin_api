defmodule BirinApiWeb.Router do
  use BirinApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", BirinApiWeb do
    pipe_through(:api)
    resources("/users", UserController, except: [:new, :edit])
    get("/ring_number", RingNumberController, :show)
    resources("/ring_numbers", RingNumberController, except: [:new, :edit])
    resources("/ring_series", RingSeriesController, except: [:new, :edit])
    get("/ring_types", RingTypesController, :index)
    get("/ring_types/allocated", RingTypesController, :allocated)
    post("/ring_series/import", RingSeriesController, :import)
    post("/users/import", UserController, :import)
  end
end
