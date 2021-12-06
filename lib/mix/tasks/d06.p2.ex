defmodule Mix.Tasks.D06.P2 do
  use Mix.Task

  import AdventOfCode.Day06

  @shortdoc "Day 06 Part 2"
  def run(args) do
    input = AdventOfCode.Input.get!(6)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> part2({input, 256}) end}),
      else:
        AdventOfCode.ExecutionTime.time_of(fn ->
          part2({input, 256})
          |> IO.inspect(label: "Part 2 Results")
        end)
  end
end
