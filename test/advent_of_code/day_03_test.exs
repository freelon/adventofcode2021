defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03

  defp input, do: "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010"

  test "part1" do
    result = part1(input())

    assert result == 198
  end

  @tag :skip
  test "part2" do
    result = part2(input)

    assert result
  end
end
