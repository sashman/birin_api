defmodule Test do
  use BirinApi.DataCase
  alias BirinApi.Import.RingsSeries

  @expected_ring_series [
    %{
      allocated_at: ~N[1980-06-16 00:00:00],
      end_number: "0D8100",
      size: 100,
      start_number: "0D8001",
      type: "AA",
      initials: "INITIALS2-12"
    },
    %{
      allocated_at: nil,
      end_number: "0D8118",
      size: 18,
      start_number: "0D8101",
      type: "AA",
      initials: "INITIALS3-12"
    },
    %{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0D8500",
      size: 300,
      start_number: "0D8201",
      type: "AA",
      initials: "INITIALS4-12"
    },
    %{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0D8700",
      size: 200,
      start_number: "0D8501",
      type: "AA",
      initials: "INITIALS5-12"
    },
    %{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0D9000",
      size: 300,
      start_number: "0D8701",
      type: "AA",
      initials: "INITIALS6-12"
    },
    %{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0M1200",
      size: 200,
      start_number: "0M1001",
      type: "AA",
      initials: "INITIALS4-12"
    },
    %{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0M1400",
      size: 200,
      start_number: "0M1201",
      type: "AA",
      initials: "INITIALS5-12"
    },
    %{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0M1600",
      size: 200,
      start_number: "0M1401",
      type: "AA",
      initials: "INITIALS9-12"
    },
    %{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0M2000",
      size: 400,
      start_number: "0M1601",
      type: "AA",
      initials: "INITIALS4-12"
    },
    %{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0P4200",
      size: 100,
      start_number: "0P4101",
      type: "AA",
      initials: "INITIALS11-12"
    },
    %{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0Y6600",
      size: 100,
      start_number: "0Y6501",
      type: "AA",
      initials: "INITIALS4-12"
    },
    %{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0Y6700",
      size: 100,
      start_number: "0Y6601",
      type: "AA",
      initials: "INITIALS5-12"
    },
    %{
      allocated_at: ~N[2011-06-16 00:00:00],
      end_number: "0Y7000",
      size: 100,
      start_number: "0Y6901",
      type: "AA",
      initials: "INITIALS4-12"
    }
  ]

  test "from_csv_file/1 returns a stream of series" do
    assert @expected_ring_series ==
             RingsSeries.from_csv_file("./test/support/ring_series.csv.test")
             |> Enum.to_list()
  end
end
