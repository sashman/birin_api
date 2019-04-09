defmodule BirinApi.RingsTest do
  use BirinApi.DataCase

  alias BirinApi.Rings
  alias BirinApi.Accounts

  describe "ring_number" do
    alias BirinApi.Rings.RingNumber

    @valid_attrs %{
      allocated_at: ~N[2010-04-17 14:00:00],
      number: "some number",
      received_at: ~N[2010-04-17 14:00:00],
      type: "some type"
    }
    @update_attrs %{
      allocated_at: ~N[2011-05-18 15:01:01],
      number: "some updated number",
      received_at: ~N[2011-05-18 15:01:01],
      type: "some updated type"
    }
    @invalid_attrs %{allocated_at: nil, number: nil, received_at: nil, type: nil}

    def ring_number_fixture(attrs \\ %{}) do
      {:ok, ring_number} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rings.create_ring_number()

      ring_number
    end

    test "list_ring_number/0 returns all ring_number" do
      ring_number = ring_number_fixture()
      assert Rings.list_ring_number() == [ring_number]
    end

    test "get_ring_number!/1 returns the ring_number with given id" do
      ring_number = ring_number_fixture()
      assert Rings.get_ring_number!(ring_number.id) == ring_number
    end

    test "create_ring_number/1 with valid data creates a ring_number" do
      assert {:ok, %RingNumber{} = ring_number} = Rings.create_ring_number(@valid_attrs)
      assert ring_number.number == "some number"
      assert ring_number.type == "some type"
    end

    test "create_ring_number/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rings.create_ring_number(@invalid_attrs)
    end

    test "update_ring_number/2 with valid data updates the ring_number" do
      ring_number = ring_number_fixture()

      assert {:ok, %RingNumber{} = ring_number} =
               Rings.update_ring_number(ring_number, @update_attrs)

      assert ring_number.number == "some updated number"
      assert ring_number.type == "some updated type"
    end

    test "update_ring_number/2 with invalid data returns error changeset" do
      ring_number = ring_number_fixture()
      assert {:error, %Ecto.Changeset{}} = Rings.update_ring_number(ring_number, @invalid_attrs)
      assert ring_number == Rings.get_ring_number!(ring_number.id)
    end

    test "delete_ring_number/1 deletes the ring_number" do
      ring_number = ring_number_fixture()
      assert {:ok, %RingNumber{}} = Rings.delete_ring_number(ring_number)
      assert_raise Ecto.NoResultsError, fn -> Rings.get_ring_number!(ring_number.id) end
    end

    test "change_ring_number/1 returns a ring_number changeset" do
      ring_number = ring_number_fixture()
      assert %Ecto.Changeset{} = Rings.change_ring_number(ring_number)
    end
  end

  describe "ring_series" do
    alias BirinApi.Rings.RingSeries

    @valid_user_attrs %{
      auth_id: "some auth_id",
      email: "some email",
      license_number: "some license_number",
      name: "some name"
    }
    @valid_attrs %{
      start_number: "ABC01",
      end_number: "ABC10",
      size: 10,
      type: "AA"
    }
    @update_attrs %{
      end_number: "some updated end_number",
      size: 43,
      start_number: "some updated start_number",
      type: "some updated type"
    }
    @invalid_attrs %{end_number: nil, size: nil, start_number: nil, type: nil}

    def ring_series_fixture(attrs \\ %{}) do
      {:ok, ring_series} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rings.create_ring_series()

      ring_series
    end

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_user_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_ring_series/0 returns all ring_series" do
      ring_series = ring_series_fixture()
      assert Rings.list_ring_series() == [ring_series]
    end

    test "get_ring_series!/1 returns the ring_series with given id" do
      ring_series = ring_series_fixture()
      assert Rings.get_ring_series!(ring_series.id) == ring_series
    end

    test "create_ring_series/1 with valid data creates a ring_series" do
      assert {:ok, %RingSeries{} = ring_series} = Rings.create_ring_series(@valid_attrs)
      assert ring_series.end_number == @valid_attrs.end_number
      assert ring_series.size == @valid_attrs.size
      assert ring_series.start_number == @valid_attrs.start_number
      assert ring_series.type == @valid_attrs.type
    end

    test "create_ring_series/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rings.create_ring_series(@invalid_attrs)
    end

    test "update_ring_series/2 with valid data updates the ring_series" do
      ring_series = ring_series_fixture()

      assert {:ok, %RingSeries{} = ring_series} =
               Rings.update_ring_series(ring_series, @update_attrs)

      assert ring_series.end_number == "some updated end_number"
      assert ring_series.size == 43
      assert ring_series.start_number == "some updated start_number"
      assert ring_series.type == "some updated type"
    end

    test "update_ring_series/2 with invalid data returns error changeset" do
      ring_series = ring_series_fixture()
      assert {:error, %Ecto.Changeset{}} = Rings.update_ring_series(ring_series, @invalid_attrs)
      assert ring_series == Rings.get_ring_series!(ring_series.id)
    end

    test "delete_ring_series/1 deletes the ring_series" do
      ring_series = ring_series_fixture()
      assert {:ok, %RingSeries{}} = Rings.delete_ring_series(ring_series)
      assert_raise Ecto.NoResultsError, fn -> Rings.get_ring_series!(ring_series.id) end
    end

    test "change_ring_series/1 returns a ring_series changeset" do
      ring_series = ring_series_fixture()
      assert %Ecto.Changeset{} = Rings.change_ring_series(ring_series)
    end

    @tag :me
    test "should create ring number for one given series" do
      list = [@valid_attrs]
      user_id = user_fixture().id

      assert {:ok, 10} == Rings.create_ring_numbers_from_series(list, user_id)
      assert 10 == Rings.list_ring_number() |> length
    end
  end
end
