defmodule BirinApiWeb.RingNumberController do
  use BirinApiWeb, :controller

  alias BirinApi.Rings
  alias BirinApi.Rings.RingNumber

  action_fallback(BirinApiWeb.FallbackController)

  def index(conn, %{"user_id" => user_id}) do
    ring_series = Rings.list_ring_number_by_user_id(user_id)
    render(conn, "index.json", ring_number: ring_series)
  end

  def index(conn, %{"ring_series_id" => ring_series_id}) do
    ring_series = Rings.list_ring_number_by_ring_series_id(ring_series_id)
    render(conn, "index.json", ring_number: ring_series)
  end

  def index(conn, _params) do
    ring_number = Rings.list_ring_number()
    render(conn, "index.json", ring_number: ring_number)
  end

  def create(conn, %{"ring_number" => ring_number_params}) do
    with {:ok, %RingNumber{} = ring_number} <- Rings.create_ring_number(ring_number_params) do
      conn
      |> put_status(:created)
      |> render("show.json", ring_number: ring_number)
    end
  end

  def show(conn, %{"number" => number}) do
    ring_number = Rings.get_ring_number_by_number(number)
    render(conn, "show.json", ring_number: ring_number)
  end

  def show(conn, %{"id" => id}) do
    ring_number = Rings.get_ring_number!(id)
    render(conn, "show.json", ring_number: ring_number)
  end

  def update(conn, %{"id" => id, "ring_number" => ring_number_params}) do
    ring_number = Rings.get_ring_number!(id)

    with {:ok, %RingNumber{} = ring_number} <-
           Rings.update_ring_number(ring_number, ring_number_params) do
      render(conn, "show.json", ring_number: ring_number)
    end
  end

  def delete(conn, %{"id" => id}) do
    ring_number = Rings.get_ring_number!(id)

    with {:ok, %RingNumber{}} <- Rings.delete_ring_number(ring_number) do
      send_resp(conn, :no_content, "")
    end
  end
end
