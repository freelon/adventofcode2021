defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  def input, do: "forward 5
down 5
forward 8
up 3
down 8
forward 2"

  test "part1" do
    result = part1(input())

    assert result == 150
  end

  test "part2" do
    result = part2(input())

    assert result == 900
  end
end
