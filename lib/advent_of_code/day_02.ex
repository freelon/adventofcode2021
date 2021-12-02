defmodule AdventOfCode.Day02 do
  def part1(args) do
    {depth, horizontal_distance} =
      args
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split/1)
      |> Enum.map(fn [a, b] -> {a, String.to_integer(b)} end)
      |> Enum.reduce(
        {0, 0},
        fn {direction, distance}, {depth, horizontal_distance} ->
          case direction do
            "forward" ->
              {depth, horizontal_distance + distance}

            "up" ->
              {depth - distance, horizontal_distance}

            "down" ->
              {depth + distance, horizontal_distance}
          end
        end
      )

    depth * horizontal_distance
  end

  def part2(args) do
    {depth, horizontal_distance, _} =
      args
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split/1)
      |> Enum.map(fn [a, b] -> {a, String.to_integer(b)} end)
      |> Enum.reduce(
        {0, 0, 0},
        fn {direction, distance}, {depth, horizontal_distance, aim} ->
          case direction do
            "forward" ->
              {depth + aim * distance, horizontal_distance + distance, aim}

            "up" ->
              {depth, horizontal_distance, aim - distance}

            "down" ->
              {depth, horizontal_distance, aim + distance}
          end
        end
      )

    depth * horizontal_distance
  end
end
