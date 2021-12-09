defmodule AdventOfCode.Day09 do
  def part1(args) do
    parse(args)
    |> get_low_points()
    |> Enum.map(fn {_, v} -> v + 1 end)
    |> Enum.sum()
  end

  defp get_low_points(m) do
    m
    |> Enum.filter(fn {p, v} ->
      neighbors(m, p) |> Enum.all?(fn other -> other > v end)
    end)
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {v, x} -> {{x, y}, v |> String.to_integer()} end)
    end)
    |> Map.new()
  end

  defp neighbors(map, {x, y}) do
    [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}]
    |> Enum.map(&Map.get(map, &1, 999))
  end

  def part2(_args) do
  end
end
