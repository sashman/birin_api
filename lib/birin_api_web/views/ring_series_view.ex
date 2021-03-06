defmodule BirinApiWeb.RingSeriesView do
  use BirinApiWeb, :view
  alias BirinApiWeb.RingSeriesView
  alias BirinApiWeb.UserView
  alias BirinApi.Accounts.User

  def render("index.json", %{ring_series: ring_series}) do
    %{data: render_many(ring_series, RingSeriesView, "ring_series.json")}
  end

  def render("show.json", %{ring_series: ring_series}) do
    %{data: render_one(ring_series, RingSeriesView, "ring_series.json")}
  end

  def render("ring_series.json", %{ring_series: ring_series}), do: render_ring_series(ring_series)

  def render_ring_series(%{user: %User{} = user} = ring_series) do
    render_ring_series(ring_series |> Map.delete(:user))
    |> Map.put(:user, UserView.render_user(user))
  end

  def render_ring_series(ring_series) do
    %{
      id: ring_series.id,
      type: ring_series.type,
      size: ring_series.size,
      start_number: ring_series.start_number,
      end_number: ring_series.end_number,
      received_at: ring_series.received_at,
      allocated_at: ring_series.allocated_at
    }
  end
end
