defmodule Mix.Tasks.D06.P1 do
  use Mix.Task

  import AdventOfCode.Day06

  @shortdoc "Day 06 Part 1"
  def run(args) do
    input = AdventOfCode.Input.get!(6)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> part1({input, 80}) end}),
      else:
        AdventOfCode.ExecutionTime.time_of(fn ->
          part1({input, 80})
          |> IO.inspect(label: "Part 1 Results")
        end)
  end
end
