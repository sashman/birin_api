defmodule BirinApiWeb.RingTypesController do
  use BirinApiWeb, :controller

  alias BirinApi.Rings

  action_fallback(BirinApiWeb.FallbackController)

  def index(conn, %{"user_id" => user_id}) do
    ring_types = Rings.list_ring_series_counts_by_type_by_user_id(user_id) |> list_to_map()

    overall_total = Enum.reduce(ring_types, 0, fn {_, total}, acc -> total + acc end)

    conn
    |> json(%{data: ring_types, total: overall_total})
  end

  def index(conn, _params) do
    ring_types = Rings.list_ring_series_counts_by_type()

    allocated_ring_types = Rings.list_ring_series_allocated_counts_by_type() |> list_to_map()

    ring_types =
      ring_types
      |> Enum.map(fn type ->
        type |> Map.put(:allocated, allocated_ring_types[type.type] || 0)
      end)

    conn
    |> json(%{data: ring_types})
  end

  def allocated(conn, _params) do
    ring_types = Rings.list_ring_series_allocated_counts_by_type()

    conn
    |> json(%{data: ring_types})
  end

  defp list_to_map(list) do
    list
    |> Enum.map(fn %{type: type, total: total} ->
      {type, total}
    end)
    |> Map.new()
  end
end
