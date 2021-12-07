defmodule AdventOfCode.Day07 do
  def part1(args) do
    crabs =
      args
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    Enum.min(crabs) .. Enum.max(crabs)
    |> Enum.map(fn pos ->
      crabs |> Enum.map(&abs(pos - &1)) |> Enum.sum()
    end)
    |> Enum.min()
  end

  def part2(_args) do
  end
end
