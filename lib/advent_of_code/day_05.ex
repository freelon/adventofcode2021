defmodule AdventOfCode.Day05 do
  def part1(args) do
    args
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, " -> ") end)
    |> Enum.map(fn [start, finish] -> {point(start), point(finish)} end)
    |> Enum.reduce(%{}, fn points, acc -> mark_points(points, acc) end)
    |> Enum.count(fn {_, v} -> v > 1 end)
  end

  defp mark_points(line, acc, opts \\ []) do
    {{x1, y1}, {x2, y2}} = line

    cond do
      x1 == x2 ->
        y1..y2
        |> Enum.reduce(acc, fn y, acc ->
          Map.put(acc, {x1, y}, Map.get(acc, {x1, y}, 0) + 1)
        end)

      y1 == y2 ->
        x1..x2
        |> Enum.reduce(acc, fn x, acc -> Map.put(acc, {x, y1}, Map.get(acc, {x, y1}, 0) + 1) end)

      :diag in opts ->
        steps = abs(y1 - y2)
        dx = round((x2 - x1) / steps)
        dy = round((y2 - y1) / steps)

        0..steps
        |> Enum.reduce(acc, fn s, acc ->
          Map.put(
            acc,
            {x1 + s * dx, y1 + s * dy},
            Map.get(acc, {x1 + s * dx, y1 + s * dy}, 0) + 1
          )
        end)

      true ->
        acc
    end
  end

  defp point(s) do
    s
    |> String.split(",")
    |> Enum.map(fn l -> l |> String.to_integer() end)
    |> case do
      [a, b] -> {a, b}
    end
  end

  def part2(args) do
    args
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, " -> ") end)
    |> Enum.map(fn [start, finish] -> {point(start), point(finish)} end)
    |> Enum.reduce(%{}, fn points, acc -> mark_points(points, acc, [:diag]) end)
    |> Enum.count(fn {_, v} -> v > 1 end)
  end
end
