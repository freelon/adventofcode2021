defmodule Mix.Tasks.D09.P1 do
  use Mix.Task

  import AdventOfCode.Day09

  @shortdoc "Day 09 Part 1"
  def run(args) do
    input = AdventOfCode.Input.get!(9)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        AdventOfCode.ExecutionTime.time_of(fn ->
          input
          |> part1()
          |> IO.inspect(label: "Part 1 Results")
        end)
  end
end
