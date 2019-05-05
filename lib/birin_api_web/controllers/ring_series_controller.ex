defmodule BirinApiWeb.RingSeriesController do
  use BirinApiWeb, :controller

  alias BirinApi.{
    Import,
    Rings,
    Rings.RingSeries
  }

  action_fallback BirinApiWeb.FallbackController

  def index(conn, %{"user_id" => user_id}) do
    ring_series = Rings.list_ring_series_by_user_id(user_id)
    render(conn, "index.json", ring_series: ring_series)
  end

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

    with {:ok, %RingSeries{} = ring_series} <-
           Rings.update_ring_series(ring_series, ring_series_params) do
      render(conn, "show.json", ring_series: ring_series)
    end
  end

  def delete(conn, %{"id" => id}) do
    ring_series = Rings.get_ring_series!(id)

    with {:ok, %RingSeries{}} <- Rings.delete_ring_series(ring_series) do
      send_resp(conn, :no_content, "")
    end
  end

  def import(conn, %{"ring_series_file" => ring_series_file = %Plug.Upload{}}) do
    extension = Path.extname(ring_series_file.filename)
    amount_created = import_file(ring_series_file.path, extension)

    conn
    |> json(%{"created_count" => amount_created})
  end

  defp import_file(filepath, ".csv") do
    {:ok, amount_created} =
      filepath
      |> Import.RingsSeries.from_csv_file()
      |> Rings.create_ring_numbers_from_series(nil)

    amount_created
  end
end
