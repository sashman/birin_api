defmodule BirinApi.Import.RingsSeries do
  alias BirinApi.Import.Common
  alias BirinApi.Rings.RingSeries

  def from_csv_file(filename), do: Common.from_csv_file(filename, &map_fields/1)

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
      allocated_at: allocated_at_string |> Common.parse_datetime() |> Common.correct_year()
    }
  end
end
