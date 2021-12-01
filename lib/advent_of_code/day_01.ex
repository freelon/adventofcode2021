defmodule AdventOfCode.Day01 do
  def part1(args) do
    radar = args
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)

    Enum.zip(radar, Enum.drop(radar, 1))
      |> Enum.filter(fn {x, y} -> y > x end)
      |> Enum.count()
  end

  def part2(args) do
    radar = args
            |> String.trim()
            |> String.split("\n")
            |> Enum.map(&String.to_integer/1)

    radar
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.map(&Enum.sum/1)
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.filter(fn [a, b] -> b > a end)
      |> Enum.count()
  end
end
