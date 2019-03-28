defmodule BirinApi.Rings.RingSerial do

  alias BirinApi.Rings

  @doc """
  ring_series_list = [
    {
      serial_start: ,
      length: ,
      serial_end: ,
      type: ,
      allocated_at: ,
      received_at: 
    }
  ]
  
  """
  
#   def create_ring_series_list(ring_series_list, user_id) when is_list(ring_series_list) do
#     ring_series_list
#     |> Enum.map(fn ring_series -> 
#       :ok = create_ring_numbers_from_series(ring_series, user_id)

#       Rings.create_ring_series(ring_series)
#     end)

#   end

  def ring_number_stream(series_length, serial_start, serial_end) do

    {prefix, start_num} = serial_parts(serial_start, series_length)
    {^prefix, end_num} = serial_parts(serial_end, series_length)

    serial_number_stream(prefix, String.to_integer(start_num), String.to_integer(end_num))
  end

  def serial_number_stream(prefix, start_num, end_num) do
    (start_num..end_num)
    |> Stream.map(fn i -> 
      prefix <> Integer.to_string(i)
    end)
  end

  def serial_parts(serial, series_length) do

    with {:ok, digit_count} <- integer_digit_count(series_length) do
        {prefix, current_count} = 
          serial
          |> String.split_at(String.length(serial) - digit_count)
      else
        {:error, msg} ->
          IO.inspect(msg)
          msg
    end   
  end  

  def integer_digit_count(series_length) when is_number(series_length) do
     {:ok, Integer.digits(series_length) |> length()}
  end

  def integer_digit_count(series_length) do
    {:error, "how very dare you"}
  end

end


