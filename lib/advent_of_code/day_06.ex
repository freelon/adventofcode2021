defmodule AdventOfCode.Day06 do
  def part1({input, dts}) do
    state = input
            |> String.trim()
            |> String.split(",")
            |> Enum.map(&String.to_integer/1)
    length(day(state, dts))
  end

  defp day(fish_list, dts) do

    new_list = List.duplicate(9, length(Enum.filter(fish_list, &(&1 == 0)))) ++ fish_list
               |> Enum.map(
                    fn fish ->
                      if fish == 0 do
                        6
                      else
                        fish - 1
                      end
                    end
                  )

    if dts > 1 do
      day(new_list, dts - 1)
    else
      new_list
    end
  end

  def part2(_args) do
  end
end