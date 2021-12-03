defmodule AdventOfCode.Day03 do
  def part1(args) do
    lines =
      args
      |> String.trim()
      |> String.split("\n")

    line_count = length(lines)
    [first | _] = lines
    width = String.length(first)

    zeros_at_indexes =
      lines
      |> Enum.reduce(%{}, fn line, acc ->
        String.graphemes(line)
        |> Enum.with_index(fn element, index -> {index, element} end)
        |> Enum.reduce(acc, fn {index, char}, acc ->
          if char == "0" do
            Map.put(acc, index, Map.get(acc, index, 0) + 1)
          else
            acc
          end
        end)
      end)

    gamma =
      0..(width - 1)
      |> Enum.map(fn index ->
        zeros = zeros_at_indexes[index]

        if zeros > line_count / 2 do
          "0"
        else
          "1"
        end
      end)

    epsilon =
      Enum.map(gamma, fn c ->
        if c == "0", do: "1", else: "0"
      end)

    epsilon

    String.to_integer(Enum.join(gamma), 2) * String.to_integer(Enum.join(epsilon), 2)
  end

  def part2(_args) do
  end
end
