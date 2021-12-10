defmodule AdventOfCode.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Day10

  defp input, do: "[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]"

  test "part1" do
    result = part1(input())

    assert result == 26397
  end

  @tag :skip
  test "part2" do
    result = part2(input())

    assert result
  end
end
