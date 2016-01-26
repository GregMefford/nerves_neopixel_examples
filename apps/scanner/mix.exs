defmodule Scanner.Mixfile do
  use Mix.Project

  def project do
    [app: :scanner,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [
      applications: [:nerves, :nerves_io_neopixel],
      mod: {Scanner, []}
    ]
  end

  defp deps do
    [
      {:nerves_io_neopixel, "~> 0.2.0"},
      {:nerves, github: "nerves-project/nerves"}
    ]
  end
end
