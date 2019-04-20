defmodule BirinApiWeb.RingTypesController do
  use BirinApiWeb, :controller

  alias BirinApi.Rings

  action_fallback(BirinApiWeb.FallbackController)

  def index(conn, _params) do
    ring_types = Rings.list_ring_series_counts_by_type()

    allocated_ring_types =
      Rings.list_ring_series_allocated_counts_by_type()
      |> Enum.map(fn %{type: type, total: total} ->
        {type, total}
      end)
      |> Map.new()

    ring_types =
      ring_types
      |> Enum.map(fn type ->
        type |> Map.put(:allocated, allocated_ring_types[type.type])
      end)

    conn
    |> json(%{data: ring_types})
  end

  def allocated(conn, _params) do
    ring_types = Rings.list_ring_series_allocated_counts_by_type()

    conn
    |> json(%{data: ring_types})
  end
end
