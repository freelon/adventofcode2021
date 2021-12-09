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
      neighbors_v(m, p) |> Enum.all?(fn other -> other > v end)
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

  defp neighbors_v(map, p) do
    neighbors(map, p) |> Enum.map(fn {_, v} -> v end)
  end

  defp neighbors(map, {x, y}) do
    [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}]
    |> Enum.filter(&Map.has_key?(map, &1))
    |> Enum.map(fn p -> {p, map[p]} end)
  end

  def part2(args) do
    map = parse(args)

    get_low_points(map)
    |> Enum.map(&get_basin(map, elem(&1, 0)))
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.reduce(1, fn size, acc -> acc * size end)
  end

  defp get_basin(map, start) do
    basin(map, [start], MapSet.new())
    |> Enum.count()
  end

  defp basin(map, [next | open], visited) do
    future =
      neighbors(map, next)
      |> Enum.filter(fn {p, v} -> v < 9 && p not in open && p not in visited end)
      |> Enum.map(&elem(&1, 0))

    basin(map, open ++ future, MapSet.put(visited, next))
  end

  defp basin(_, [], visited) do
    visited
  end
end
