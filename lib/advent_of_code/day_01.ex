defmodule AdventOfCode.Day01 do
  import String
  import Enum

  def part1(args) do
    radar =
      args
      |> trim()
      |> String.split("\n")
      |> map(&to_integer/1)

    zip(radar, drop(radar, 1))
    |> count(fn {x, y} -> y > x end)
  end

  def part2(args) do
    radar =
      args
      |> trim()
      |> String.split("\n")
      |> map(&to_integer/1)

    radar
    |> chunk_every(3, 1, :discard)
    |> map(&sum/1)
    |> chunk_every(2, 1, :discard)
    |> count(fn [x, y] -> y > x end)
  end
end
