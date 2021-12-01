defmodule Mix.Tasks.D07.P2 do
  use Mix.Task

  import AdventOfCode.Day07

  @shortdoc "Day 07 Part 2"
  def run(args) do
    input = nil

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        AdventOfCode.ExecutionTime.time_of(fn ->
          input
          |> part2()
          |> IO.inspect(label: "Part 2 Results")
        end)
  end
end
