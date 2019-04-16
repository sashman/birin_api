defmodule BirinApi.Rings.RingSerialTest do
  use BirinApi.DataCase
  alias BirinApi.Rings.RingSerial

  test "serial_parts/2 returns the prefix and the number parts of a serial and length of changable integer" do
    assert RingSerial.serial_parts("NZ77101") == {"NZ", "77101", 5}
    assert RingSerial.serial_parts("0D8701") == {"0D", "8701", 4}
    assert RingSerial.serial_parts("12345") == {"", "12345", 5}
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

  test "ring_number_stream/3 returns a stream of serials numbers given a start and end serials and a length" do
    serial_numbers = RingSerial.ring_number_stream("ABC01", "ABC10") |> Enum.to_list()
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

  test "ring_number_stream/3 handles overflow" do
    serial_numbers = RingSerial.ring_number_stream("ABC08", "ABC10") |> Enum.to_list()
    assert serial_numbers |> length == 3

    assert serial_numbers == [
             "ABC08",
             "ABC09",
             "ABC10"
           ]
  end
end
