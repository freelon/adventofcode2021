defmodule Mix.Tasks.D05.P2 do
  use Mix.Task

  import AdventOfCode.Day05

  @shortdoc "Day 05 Part 2"
  def run(args) do
    Mix.Task.run("app.start")
    input = AdventOfCode.Input.get!(5)

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
