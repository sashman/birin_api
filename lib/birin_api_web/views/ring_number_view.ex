defmodule BirinApiWeb.RingNumberView do
  use BirinApiWeb, :view
  alias BirinApiWeb.{RingNumberView, RingSeriesView}
  alias BirinApi.Rings.RingSeries

  def render("index.json", %{ring_number: ring_number}) do
    %{data: render_many(ring_number, RingNumberView, "ring_number.json")}
  end

  def render("show.json", %{ring_number: ring_number}) do
    %{data: render_one(ring_number, RingNumberView, "ring_number.json")}
  end

  def render("ring_number.json", %{ring_number: ring_number}), do: render_ring_number(ring_number)

  def render_ring_number(%{ring_series: %RingSeries{} = ring_series} = ring_number) do
    render_ring_number(ring_number |> Map.delete(:ring_series))
    |> Map.put(:ring_series, RingSeriesView.render_ring_series(ring_series))
  end

  def render_ring_number(ring_number) do
    %{id: ring_number.id, type: ring_number.type, number: ring_number.number}
  end
end
