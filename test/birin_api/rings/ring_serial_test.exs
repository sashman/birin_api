defmodule BirinApi.Rings.RingSerialTest do
  use BirinApi.DataCase
  alias BirinApi.Rings.RingSerial

  test "serial_parts/2 returns the prefix and the number parts of a serial and length of changable integer" do
    assert RingSerial.serial_parts("NZ77101", 2900) == {"NZ7", "7101", 4}
  end

  test "serial_number_stream/3 returns a stream of serials numbers given a start and end numbers and a prefix" do
    serial_numbers = RingSerial.serial_number_stream("ABC", 5, 9, 1) |> Enum.to_list()
    assert serial_numbers |> length == 5

    assert serial_numbers == [
             "ABC5",
             "ABC6",
             "ABC7",
             "ABC8",
             "ABC9"
           ]
  end

  @tag :me
  test "ring_number_stream/3 returns a stream of serials numbers given a start and end serials and a length" do
    serial_numbers = RingSerial.ring_number_stream(10, "ABC01", "ABC10") |> Enum.to_list()
    assert serial_numbers |> length == 10

    assert serial_numbers == [
             "ABC01",
             "ABC02",
             "ABC03",
             "ABC04",
             "ABC05",
             "ABC06",
             "ABC07",
             "ABC08",
             "ABC09",
             "ABC10"
           ]
  end
end
