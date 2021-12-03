defmodule AdventOfCode.Day03 do
  def part1(args) do
    lines =
      args
      |> String.trim()
      |> String.split("\n")

    line_count = length(lines)
    [first | _] = lines
    width = String.length(first)

    zeros_at_indexes =
      lines
      |> Enum.reduce(%{}, fn line, acc ->
        String.graphemes(line)
        |> Enum.with_index(fn element, index -> {index, element} end)
        |> Enum.reduce(acc, fn {index, char}, acc ->
          if char == "0" do
            Map.put(acc, index, Map.get(acc, index, 0) + 1)
          else
            acc
          end
        end)
      end)

    gamma =
      0..(width - 1)
      |> Enum.map(fn index ->
        zeros = zeros_at_indexes[index]

        if zeros > line_count / 2 do
          "0"
        else
          "1"
        end
      end)

    epsilon =
      Enum.map(gamma, fn c ->
        if c == "0", do: "1", else: "0"
      end)

    String.to_integer(Enum.join(gamma), 2) * String.to_integer(Enum.join(epsilon), 2)
  end

  def part2(args) do
    lines =
      args
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)

    oxygen_generator_rating = select_by_bit_criterion(lines, :most_common, "1")
    co2_scrubber_rating = select_by_bit_criterion(lines, :least_common, "0")

    String.to_integer(Enum.join(oxygen_generator_rating), 2) *
      String.to_integer(Enum.join(co2_scrubber_rating), 2)
  end

  defp select_by_bit_criterion(list, bit_selector, tie_breaker_bit) do
    select_by_bit_criterion(list, bit_selector, tie_breaker_bit, 0)
  end

  defp select_by_bit_criterion([x], _, _, _), do: x

  defp select_by_bit_criterion(list, bit_selector, tie_breaker_bit, index) do
    len = Enum.count(list)

    zeros =
      list
      |> Enum.map(fn line -> Enum.at(line, index) end)
      |> Enum.filter(fn c -> c == "0" end)
      |> Enum.count()

    most_used_bit =
      cond do
        zeros > len / 2 -> "0"
        len - zeros > len / 2 -> "1"
        true -> nil
      end

    filter_bit =
      case bit_selector do
        :most_common ->
          if most_used_bit != nil, do: most_used_bit, else: tie_breaker_bit

        :least_common ->
          if most_used_bit != nil, do: reverse(most_used_bit), else: tie_breaker_bit
      end

    shortened_list = list |> Enum.filter(fn line -> Enum.at(line, index) == filter_bit end)
    select_by_bit_criterion(shortened_list, bit_selector, tie_breaker_bit, index + 1)
  end

  defp reverse("0"), do: "1"
  defp reverse("1"), do: "0"
end
