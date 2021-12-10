defmodule AdventOfCode.Day10 do
  def part1(args) do
    args
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&solve(&1, []))
    |> Enum.sum()
  end

  def solve([next | following], opened) do
    :logger.info("next: #{next} | #{following} -- #{opened}")
    price = %{
      ")" => 3,
      "]" => 57,
      "}" => 1197,
      ">" => 25137
    }

    if illegal(next, opened) do
      price[next]
    else
      if next in Map.keys(price) do
        [_ | stack] = opened
        solve(following, stack)
      else
        solve(following, [next] ++ opened)
      end
    end
  end

  defp illegal(char, opened) do
    map = %{
      "(" => ")",
      "[" => "]",
      "{" => "}",
      "<" => ">"
    }

    if char in Map.keys(map) do
      false
    else
      if length(opened) == 0 do
        true
      else
        [opener | _] = opened
        char != map[opener]
      end
    end
  end

  def solve([], _opened) do
    0
  end

  def part2(_args) do
  end
end
