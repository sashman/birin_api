defmodule BirinApi.Import.RingsSeries do
  alias BirinApi.Rings.RingSeries

  def from_csv_file(filename) do
    File.stream!(filename)
    |> CSV.decode(headers: true)
    |> Stream.map(fn {:ok, series} ->
      series
      |> map_fields()
    end)
  end

  defp map_fields(%{
         "ALLOC_DTE" => allocated_at_string,
         "INIT" => _initials,
         "RCVD_DTE" => _received_at,
         "SEREND" => end_number,
         "SERIES" => start_number,
         "SERLEN" => size,
         "SIZE" => type
       }) do
    %RingSeries{
      type: type,
      size: String.to_integer(size),
      start_number: start_number,
      end_number: end_number,
      allocated_at: allocated_at_string |> parse_datetime() |> correct_year()
    }
  end

  defp parse_datetime(""), do: nil

  defp parse_datetime(datetime), do: datetime |> Timex.parse!("%m/%d/%y %T", :strftime)

  defp correct_year(nil), do: nil

  defp correct_year(datetime) do
    now =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    NaiveDateTime.compare(datetime, now)
    |> case do
      :gt -> datetime |> Timex.shift(years: -100)
      _ -> datetime
    end
  end
end
