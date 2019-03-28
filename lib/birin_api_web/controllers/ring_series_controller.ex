defmodule BirinApiWeb.RingSeriesController do
  use BirinApiWeb, :controller

  alias BirinApi.Rings
  alias BirinApi.Rings.RingSeries

  action_fallback BirinApiWeb.FallbackController

  def index(conn, _params) do
    ring_series = Rings.list_ring_series()
    render(conn, "index.json", ring_series: ring_series)
  end

  def create(conn, %{"ring_series" => ring_series_params}) do
    with {:ok, %RingSeries{} = ring_series} <- Rings.create_ring_series(ring_series_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.ring_series_path(conn, :show, ring_series))
      |> render("show.json", ring_series: ring_series)
    end
  end

  def show(conn, %{"id" => id}) do
    ring_series = Rings.get_ring_series!(id)
    render(conn, "show.json", ring_series: ring_series)
  end

  def update(conn, %{"id" => id, "ring_series" => ring_series_params}) do
    ring_series = Rings.get_ring_series!(id)

    with {:ok, %RingSeries{} = ring_series} <- Rings.update_ring_series(ring_series, ring_series_params) do
      render(conn, "show.json", ring_series: ring_series)
    end
  end

  def delete(conn, %{"id" => id}) do
    ring_series = Rings.get_ring_series!(id)

    with {:ok, %RingSeries{}} <- Rings.delete_ring_series(ring_series) do
      send_resp(conn, :no_content, "")
    end
  end
end
