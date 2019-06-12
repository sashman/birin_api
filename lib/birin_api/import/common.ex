defmodule BirinApi.Import.Common do
  def from_csv_file(filename, map_fields_fn) do
    File.stream!(filename)
    |> CSV.decode(headers: true)
    |> Stream.map(fn {:ok, series} ->
      series
      |> map_fields_fn.()
    end)
  end

  def parse_datetime(""), do: nil

  def parse_datetime(datetime), do: datetime |> Timex.parse!("%m/%d/%y %T", :strftime)

  def correct_year(nil), do: nil

  def correct_year(datetime) do
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
