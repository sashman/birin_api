defmodule BirinApi.Rings.RingSerialTest do
    use BirinApi.DataCase
    alias BirinApi.Rings.RingSerial
    
    @tag :me
    test "serial_parts/2 returns the prefix and the number parts of a serial" do
        assert RingSerial.serial_parts("NZ77101", 2900) == {"NZ7", "7101"}
    end

    @tag :me
    test "serial_number_stream/3 returns a stream of serials numbers given a start and end numbers and a prefix" do
        serial_numbers = RingSerial.serial_number_stream("ABC", 5, 9) |> Enum.to_list()
        assert serial_numbers |> length == 5
        assert serial_numbers == [
            "ABC5", "ABC6", "ABC7", "ABC8", "ABC9"
        ]
    end

    @tag :me
    test "ring_number_stream/3 returns a stream of serials numbers given a start and end serials and a length" do
        serial_numbers = RingSerial.ring_number_stream(5, "ABC01", "ABC05") |> Enum.to_list()
        assert serial_numbers |> length == 5
        assert serial_numbers == [
            "ABC01", "ABC02", "ABC03", "ABC04", "ABC05"
        ]
    end

end