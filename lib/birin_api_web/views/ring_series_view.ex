defmodule BirinApiWeb.RingSeriesView do
  use BirinApiWeb, :view
  alias BirinApiWeb.RingSeriesView

  def render("index.json", %{ring_series: ring_series}) do
    %{data: render_many(ring_series, RingSeriesView, "ring_series.json")}
  end

  def render("show.json", %{ring_series: ring_series}) do
    %{data: render_one(ring_series, RingSeriesView, "ring_series.json")}
  end

  def render("ring_series.json", %{ring_series: ring_series}) do
    %{id: ring_series.id,
      type: ring_series.type,
      size: ring_series.size,
      start_number: ring_series.start_number,
      end_number: ring_series.end_number}
  end
end
