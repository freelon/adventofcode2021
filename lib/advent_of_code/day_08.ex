defmodule AdventOfCode.Day08 do
  def part1(args) do
    args
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " | "))
    |> Enum.map(fn [wires, outputs] -> {wires |> String.split(), outputs |> String.split()} end)
    |> Enum.flat_map(fn {_, outputs} ->
      outputs
      |> Enum.map(&String.length/1)
    end)
    |> Enum.count(&(&1 in [2, 3, 4, 7]))
  end

  def part2(args) do
    args
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " | "))
    |> Enum.map(fn [wires, outputs] ->
      {wires |> String.split() |> Enum.map(&(&1 |> String.graphemes() |> MapSet.new())),
       outputs |> String.split() |> Enum.map(&(&1 |> String.graphemes() |> MapSet.new()))}
    end)
    |> Enum.map(&solve/1)
    |> Enum.sum()
  end

  def solve({wires, outputs}) do
    solved = %{
      1 => wires |> Enum.find(&(Enum.count(&1) == 2)),
      4 => wires |> Enum.find(&(Enum.count(&1) == 4)),
      7 => wires |> Enum.find(&(Enum.count(&1) == 3)),
      8 => wires |> Enum.find(&(Enum.count(&1) == 7))
    }

    solved =
      Map.put(
        solved,
        0,
        Enum.find(wires, fn wire ->
          Enum.count(wire) == 6 and MapSet.subset?(solved[1], wire) and
            not MapSet.subset?(solved[4], wire)
        end)
      )

    solved =
      Map.put(
        solved,
        6,
        Enum.find(wires, fn wire ->
          Enum.count(wire) == 6 and MapSet.intersection(solved[0], wire) |> Enum.count() == 5 and
            not MapSet.subset?(solved[4], wire)
        end)
      )

    solved =
      Map.put(
        solved,
        9,
        Enum.find(wires, fn wire ->
          Enum.count(wire) == 6 and MapSet.intersection(solved[0], wire) |> Enum.count() == 5 and
            MapSet.subset?(solved[4], wire)
        end)
      )

    solved =
      Map.put(
        solved,
        2,
        Enum.find(wires, fn wire ->
          Enum.count(wire) == 5 and MapSet.intersection(solved[6], wire) |> Enum.count() == 4 and
            MapSet.intersection(solved[1], wire) |> Enum.count() == 1
        end)
      )

    solved =
      Map.put(
        solved,
        3,
        Enum.find(wires, fn wire ->
          Enum.count(wire) == 5 and MapSet.intersection(solved[1], wire) |> Enum.count() == 2
        end)
      )

    solved =
      Map.put(
        solved,
        5,
        Enum.find(wires, fn wire ->
          Enum.count(wire) == 5 and MapSet.intersection(solved[6], wire) |> Enum.count() == 5
        end)
      )

    reverts = solved |> Enum.map(fn {i, s} -> {s, Integer.to_string(i)} end) |> Map.new()

    if Enum.count(reverts) < 10 do
      :logger.error("#{inspect(wires |> Enum.map(&(&1 |> MapSet.to_list() |> Enum.join())))}")
      :logger.error("missing: #{inspect(wires |> Enum.find(&(&1 not in Map.keys(reverts))))}")
      raise "fuck"
    end

    outputs
    |> Enum.map(&Map.get(reverts, &1))
    |> Enum.join()
    |> String.to_integer()
  end

  def smart(args) do
    [wires, outputs] =
      args
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, " | "))
      |> Enum.map(fn [wires, outputs] ->
        {wires |> Enum.map(fn wire -> wire |> String.split() |> String.graphemes() end),
         outputs |> Enum.map(fn wire -> wire |> String.split() |> String.graphemes() end)}
      end)

    numbers = %{
      0 => "abcefg",
      1 => "cf",
      2 => "acdeg",
      3 => "acdfg",
      4 => "bcdf",
      5 => "abdfg",
      6 => "abdefg",
      7 => "acf",
      8 => "abcdefg",
      9 => "abcdfg"
    }

    reverts = numbers |> Enum.map(fn {a, b} -> {b, a} end) |> Map.new()

    chars =
      "abcdefg"
      |> String.graphemes()

    match_perm =
      chars
      |> perm()
      |> Enum.find(fn l ->
        mapping = Enum.zip(l, chars)

        wires
        |> Enum.all?(fn wire ->
          x =
            wire
            |> String.graphemes()
            |> Enum.map(&Map.get(mapping, &1))
            |> Enum.join()

          x in Map.keys(reverts)
        end)
      end)

    mapping = Enum.zip(match_perm, chars)

    outputs
    |> Enum.map(fn o ->
      o
      |> Enum.map(
        &(Map.get(mapping, &1)
          |> Enum.join())
      )
    end)
    |> Enum.map(fn o -> reverts[o] end)
    |> Integer.undigits()
  end

  def perm([]) do
    [[]]
  end

  def perm(list) do
    for h <- list, t <- perm(list -- [h]), do: [h | t]
  end
end
