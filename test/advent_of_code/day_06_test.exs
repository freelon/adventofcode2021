defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  test "part1" do
    input = "3,4,3,1,2"

    assert part1({input, 18}) == 26
    assert part1({input, 80}) == 5934
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
