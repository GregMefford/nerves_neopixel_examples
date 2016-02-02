defmodule Gibson do
  @moduledoc false

  use Application
  alias Nerves.IO.Neopixel
  alias Nerves.IO.Ethernet

  # Display each "frame" on the NeoPixel strip for this many milliseconds
  @frame_delay 500

  # How many NeoPixels are in the strip
  @pixel_count 72

  # GPIO pin the NeoPixel strip is connected to (probably 18 for Raspberry Pi)
  @gpio_pin 18

  def start(_type, _args) do
    {:ok, pid} = Neopixel.setup(pin: @gpio_pin, count: @pixel_count)
    render(pid)
  end

  def render(pid) do
    #image = :crypto.rand_bytes(@pixel_count)
    #  |> :binary.bin_to_list
    #  |> Enum.flat_map(fn(x) -> [0, x, 0] end)
    #  |> :binary.list_to_bin
    
    _render(pid, 0)
  end

  defp _render(pid, index) do
    offset = rem(index, 3)
    front_buffer = String.duplicate(<<0, 0, 0>>, offset)
    pattern = String.duplicate(<<0, 127, 0, 0, 32, 0, 0, 0, 0>>, div(@pixel_count-1, 3) - offset)
    image = front_buffer <> pattern
    Neopixel.render(pid, image)
    :timer.sleep(@frame_delay)
    _render(pid, index + 1)
  end

end
