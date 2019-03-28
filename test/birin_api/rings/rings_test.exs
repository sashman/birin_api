defmodule BirinApi.RingsTest do
  use BirinApi.DataCase

  alias BirinApi.Rings

  describe "ring_number" do
    alias BirinApi.Rings.RingNumber

    @valid_attrs %{allocated_at: ~N[2010-04-17 14:00:00], number: "some number", received_at: ~N[2010-04-17 14:00:00], type: "some type"}
    @update_attrs %{allocated_at: ~N[2011-05-18 15:01:01], number: "some updated number", received_at: ~N[2011-05-18 15:01:01], type: "some updated type"}
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
      assert ring_number.allocated_at == ~N[2010-04-17 14:00:00]
      assert ring_number.number == "some number"
      assert ring_number.received_at == ~N[2010-04-17 14:00:00]
      assert ring_number.type == "some type"
    end

    test "create_ring_number/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rings.create_ring_number(@invalid_attrs)
    end

    test "update_ring_number/2 with valid data updates the ring_number" do
      ring_number = ring_number_fixture()
      assert {:ok, %RingNumber{} = ring_number} = Rings.update_ring_number(ring_number, @update_attrs)
      assert ring_number.allocated_at == ~N[2011-05-18 15:01:01]
      assert ring_number.number == "some updated number"
      assert ring_number.received_at == ~N[2011-05-18 15:01:01]
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
end
