defmodule BirinApi.Import.RingsSeries do
  alias BirinApi.Rings.RingSeries

  def from_csv_file(filename) do
    File.stream!(filename)
    |> CSV.decode(headers: true)
    |> Stream.take(2)
    |> Stream.map(fn {:ok, series} ->
      series
      |> map_fields()
    end)
  end

  defp map_fields(%{
         "ALLOC_DTE" => _allocated_at,
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
      end_number: end_number
    }
  end
end
