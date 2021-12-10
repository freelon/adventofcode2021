defmodule AdventOfCode.Day10 do
  def part1(args) do
    args
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&solve(&1, []))
    |> IO.inspect()
  end

  def solve([next | following], opened) do
    #    :logger.info("next: #{next} | #{following} -- #{opened}")
    closers = [
      ")",
      "]",
      "}",
      ">"
    ]

    if illegal(next, opened) do
      []
    else
      if next in closers do
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

  def solve([], opened) do
    opened
  end

  def close(list) do
    map = %{
      "(" => ")",
      "[" => "]",
      "{" => "}",
      "<" => ">"
    }

    list |> Enum.map(&map[&1])
  end

  def part2(args) do
    price = %{
      ")" => 1,
      "]" => 2,
      "}" => 3,
      ">" => 4
    }

    costs =
      args
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&solve(&1, []))
      |> Enum.map(&close/1)
      |> Enum.filter(&(not Enum.empty?(&1)))
      |> Enum.map(fn line ->
        line
        |> Enum.reduce(0, fn c, acc ->
          acc * 5 + price[c]
        end)
      end)
      |> Enum.sort()

    costs |> Enum.drop(round((length(costs) - 1) / 2)) |> hd()
  end
end
