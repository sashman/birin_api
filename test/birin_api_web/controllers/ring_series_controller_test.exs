defmodule BirinApiWeb.RingSeriesControllerTest do
  use BirinApiWeb.ConnCase

  alias BirinApi.Rings
  alias BirinApi.Rings.RingSeries

  @create_attrs %{
    end_number: "some end_number",
    size: 42,
    start_number: "some start_number",
    type: "some type",
    allocated_at: ~N[2010-04-17 14:00:00],
    received_at: ~N[2010-04-17 14:00:00]
  }
  @update_attrs %{
    end_number: "some updated end_number",
    size: 43,
    start_number: "some updated start_number",
    type: "some updated type",
    allocated_at: ~N[2010-04-17 14:00:00],
    received_at: ~N[2010-04-17 14:00:00]
  }
  @invalid_attrs %{end_number: nil, size: nil, start_number: nil, type: nil}

  def fixture(:ring_series) do
    {:ok, ring_series} = Rings.create_ring_series(@create_attrs)
    ring_series
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all ring_series", %{conn: conn} do
      conn = get(conn, Routes.ring_series_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create ring_series" do
    test "renders ring_series when data is valid", %{conn: conn} do
      conn = post(conn, Routes.ring_series_path(conn, :create), ring_series: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.ring_series_path(conn, :show, id))

      assert %{
               "id" => id,
               "end_number" => "some end_number",
               "size" => 42,
               "start_number" => "some start_number",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.ring_series_path(conn, :create), ring_series: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update ring_series" do
    setup [:create_ring_series]

    test "renders ring_series when data is valid", %{
      conn: conn,
      ring_series: %RingSeries{id: id} = ring_series
    } do
      conn =
        put(conn, Routes.ring_series_path(conn, :update, ring_series), ring_series: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.ring_series_path(conn, :show, id))

      assert %{
               "id" => id,
               "end_number" => "some updated end_number",
               "size" => 43,
               "start_number" => "some updated start_number",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, ring_series: ring_series} do
      conn =
        put(conn, Routes.ring_series_path(conn, :update, ring_series), ring_series: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete ring_series" do
    setup [:create_ring_series]

    test "deletes chosen ring_series", %{conn: conn, ring_series: ring_series} do
      conn = delete(conn, Routes.ring_series_path(conn, :delete, ring_series))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.ring_series_path(conn, :show, ring_series))
      end
    end
  end

  defp create_ring_series(_) do
    ring_series = fixture(:ring_series)
    {:ok, ring_series: ring_series}
  end
end
