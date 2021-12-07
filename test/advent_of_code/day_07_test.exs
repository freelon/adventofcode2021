defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07

  defp input, do: "16,1,2,0,4,2,7,1,2,14"

  test "part1" do
    result = part1(input())

    assert result == 37
  end

  test "part2" do
    result = part2(input())

    assert result == 168
  end
end
