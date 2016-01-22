defmodule Scanner do
  @moduledoc false

  use Application
  alias Nerves.IO.Neopixel

  # Display each "frame" on the NeoPixel strip for this many milliseconds
  @frame_delay 5

  # How many NeoPixels are in the strip
  @pixel_count 72

  # GPIO pin the NeoPixel strip is connected to (probably 18 for Raspberry Pi)
  @gpio_pin 18

  def start(_type, _args) do
    {:ok, pid} = Neopixel.setup(pin: @gpio_pin, count: @pixel_count)
    scan(pid)
  end

  def scan(pid) do
    Stream.concat(0..(@pixel_count - 1), (@pixel_count - 1)..0)
    |> Enum.each(&_scan(&1, pid))
    scan(pid)
  end

  defp _scan(index, pid) do
    offset = rem(index, @pixel_count)
    front_buffer_bits = offset * 8 * 3
    back_buffer_bits  = (@pixel_count - offset - 1) * 8 * 3
    pixel_data = << 0 :: size(front_buffer_bits), 255, 0, 0, 0 :: size(back_buffer_bits) >>
    Neopixel.render(pid, pixel_data)
    :timer.sleep(@frame_delay)
  end

end
