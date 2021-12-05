defmodule Mix.Tasks.D05.P1 do
  use Mix.Task

  import AdventOfCode.Day05

  @shortdoc "Day 05 Part 1"
  def run(args) do
    Mix.Task.run("app.start")
    input = AdventOfCode.Input.get!(5)

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
