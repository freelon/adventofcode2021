defmodule AdventOfCode.Day06 do
  def part1({input, dts}) do
    state =
      input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    length(day(state, dts))
  end

  defp day(fish_list, dts) do
    new_list =
      (List.duplicate(9, length(Enum.filter(fish_list, &(&1 == 0)))) ++ fish_list)
      |> Enum.map(fn fish ->
        if fish == 0 do
          6
        else
          fish - 1
        end
      end)

    if dts > 1 do
      day(new_list, dts - 1)
    else
      new_list
    end
  end

  def part2({input, dts}) do
    start =
      input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()
      |> Map.new()

    0..8
    |> Map.new(&{&1, 0})
    |> Map.merge(start)
    |> Enum.sort()
    |> Enum.map(fn {_, count} -> count end)
    |> IO.inspect()
    |> smart_day(dts)
    |> Enum.sum()
  end

  defp smart_day([a, b, c, d, e, f, g, h, i], dts) do
    new_list = [b, c, d, e, f, g, h + a, i, a]

    if dts > 1 do
      smart_day(new_list, dts - 1)
    else
      new_list
    end
  end
end
