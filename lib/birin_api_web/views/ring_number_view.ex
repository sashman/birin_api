defmodule BirinApiWeb.RingNumberView do
  use BirinApiWeb, :view
  alias BirinApiWeb.RingNumberView

  def render("index.json", %{ring_number: ring_number}) do
    %{data: render_many(ring_number, RingNumberView, "ring_number.json")}
  end

  def render("show.json", %{ring_number: ring_number}) do
    %{data: render_one(ring_number, RingNumberView, "ring_number.json")}
  end

  def render("ring_number.json", %{ring_number: ring_number}) do
    %{id: ring_number.id,
      type: ring_number.type,
      number: ring_number.number,
      received_at: ring_number.received_at,
      allocated_at: ring_number.allocated_at}
  end
end
