defmodule BirinApi.Rings.RingSeriesTest do
  use BirinApi.DataCase
  alias BirinApi.Import.RingsSeries

  @expected_ring_series [
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0D8100",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 100,
      start_number: "0D8001",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0D8118",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 18,
      start_number: "0D8101",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0D8500",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 300,
      start_number: "0D8201",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0D8700",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 200,
      start_number: "0D8501",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0D9000",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 300,
      start_number: "0D8701",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0M1200",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 200,
      start_number: "0M1001",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0M1400",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 200,
      start_number: "0M1201",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0M1600",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 200,
      start_number: "0M1401",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0M2000",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 400,
      start_number: "0M1601",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0P4200",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 100,
      start_number: "0P4101",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0Y6600",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 100,
      start_number: "0Y6501",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0Y6700",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 100,
      start_number: "0Y6601",
      type: "AA",
      updated_at: nil
    },
    %BirinApi.Rings.RingSeries{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0Y7000",
      id: nil,
      inserted_at: nil,
      received_at: nil,
      size: 100,
      start_number: "0Y6901",
      type: "AA",
      updated_at: nil
    }
  ]

  @tag :me
  test "from_csv_file/1 returns a stream of series" do
    assert @expected_ring_series ==
             RingsSeries.from_csv_file("./test/support/ring_series.csv.test")
             |> Enum.to_list()
  end
end
