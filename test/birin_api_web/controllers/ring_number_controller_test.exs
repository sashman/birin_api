defmodule BirinApiWeb.RingNumberControllerTest do
  use BirinApiWeb.ConnCase

  alias BirinApi.Rings
  alias BirinApi.Rings.RingNumber

  @create_attrs %{
    number: "some number",
    type: "some type"
  }
  @update_attrs %{
    number: "some updated number",
    type: "some updated type"
  }
  @invalid_attrs %{allocated_at: nil, number: nil, received_at: nil, type: nil}

  def fixture(:ring_number) do
    {:ok, ring_number} = Rings.create_ring_number(@create_attrs)
    ring_number
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all ring_number", %{conn: conn} do
      conn = get(conn, Routes.ring_number_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create ring_number" do
    test "renders ring_number when data is valid", %{conn: conn} do
      conn = post(conn, Routes.ring_number_path(conn, :create), ring_number: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.ring_number_path(conn, :show, id))

      assert %{
               "id" => id,
               "number" => "some number",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.ring_number_path(conn, :create), ring_number: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update ring_number" do
    setup [:create_ring_number]

    test "renders ring_number when data is valid", %{
      conn: conn,
      ring_number: %RingNumber{id: id} = ring_number
    } do
      conn =
        put(conn, Routes.ring_number_path(conn, :update, ring_number), ring_number: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.ring_number_path(conn, :show, id))

      assert %{
               "id" => id,
               "number" => "some updated number",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, ring_number: ring_number} do
      conn =
        put(conn, Routes.ring_number_path(conn, :update, ring_number), ring_number: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete ring_number" do
    setup [:create_ring_number]

    test "deletes chosen ring_number", %{conn: conn, ring_number: ring_number} do
      conn = delete(conn, Routes.ring_number_path(conn, :delete, ring_number))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.ring_number_path(conn, :show, ring_number))
      end
    end
  end

  defp create_ring_number(_) do
    ring_number = fixture(:ring_number)
    {:ok, ring_number: ring_number}
  end
end
