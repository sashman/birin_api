defmodule BirinApiWeb.RingTypesController do
  use BirinApiWeb, :controller

  alias BirinApi.Rings

  action_fallback(BirinApiWeb.FallbackController)

  def index(conn, _params) do
    ring_types = Rings.list_ring_series_counts_by_type()

    conn
    |> json(%{data: ring_types})
  end

  def allocated(conn, _params) do
    ring_types = Rings.list_ring_series_allocated_counts_by_type()

    conn
    |> json(%{data: ring_types})
  end
end
