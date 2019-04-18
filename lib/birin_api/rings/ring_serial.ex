defmodule BirinApi.Rings.RingSerial do
  def ring_number_stream(serial_start, serial_end) do
    {prefix, start_num, digit_count} = serial_parts(serial_start)
    {_prefix, end_num, ^digit_count} = serial_parts(serial_end)

    serial_number_stream(
      prefix,
      String.to_integer(start_num),
      String.to_integer(end_num),
      digit_count
    )
  end

  def serial_number_stream(prefix, start_num, end_num, digit_count) do
    start_num..end_num
    |> Stream.map(fn i ->
      prefix <> String.pad_leading(Integer.to_string(i), digit_count, "0")
    end)
  end

  def serial_parts(serial) do
    [prefix, current_count] =
      String.split(serial, ~r{.*[A-Za-z]+}, include_captures: true, trim: true)
      |> parse_matches()

    {prefix, current_count, current_count |> String.length()}
  end

  defp parse_matches([]), do: ["", "0"]
  defp parse_matches([current_count]), do: ["", current_count]
  defp parse_matches([_prefix, _current_count] = m), do: m
  defp parse_matches(m), do: "Unable to parse #{m}"
end
