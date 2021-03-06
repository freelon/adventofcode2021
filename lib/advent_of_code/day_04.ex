defmodule AdventOfCode.Day04 do
  #  width == height
  defmodule Board do
    defstruct [:width, :fields]

    def create(lines) do
      :logger.debug("board input: #{inspect(lines)}")
      width = Enum.count(lines)

      fields =
        lines
        |> Enum.with_index()
        |> Enum.flat_map(fn {line, y} ->
          line
          |> Enum.with_index()
          |> Enum.map(fn {v, x} -> {{x, y}, v} end)
        end)
        |> Map.new()

      %Board{width: width, fields: fields}
    end

    def get_row(board, y) do
      board.fields
      |> Enum.filter(fn {{_, fy}, _} -> fy == y end)
      |> Enum.sort_by(fn {{x, _}, _} -> x end)
    end

    def get_col(board, x) do
      board.fields
      |> Enum.filter(fn {{fx, _}, _} -> fx == x end)
      |> Enum.sort_by(fn {{_, y}, _} -> y end)
    end

    def row_empty(board, y) do
      not (board.fields |> Enum.any?(fn {{_, fy}, _} -> fy == y end))
    end

    def col_empty(board, x) do
      not (board.fields |> Enum.any?(fn {{fx, _}, _} -> fx == x end))
    end
  end

  def part1(args) do
    {numbers, boards} = parse(args)

    {checked, [winner | _]} = get_first_bingo([], numbers, boards)

    :logger.debug("checked: #{hd(checked)}")

    sum =
      winner.fields
      |> Enum.map(fn {_, n} -> n end)
      |> Enum.filter(fn n -> not Enum.member?(checked, n) end)
      |> Enum.sum()

    :logger.debug("unmarked sum: #{sum}")
    hd(checked) * sum
  end

  #  returns {list of checked, list of boards with bingo}
  defp get_first_bingo(checked, open, boards) do
    xyz = [hd(open)] ++ checked

    :logger.debug(
      "checked: #{inspect(checked, charlists: :as_lists)} - open: #{inspect(open, charlists: :as_lists)}"
    )

    bingos = boards |> Enum.filter(&is_bingo(xyz, &1))

    if Enum.empty?(bingos) do
      get_first_bingo(xyz, tl(open), boards)
    else
      {xyz, bingos}
    end
  end

  defp is_bingo(numbers, board) do
    all_rows_cols =
      (0..(board.width - 1) |> Enum.map(&Board.get_row(board, &1))) ++
        (0..(board.width - 1) |> Enum.map(&Board.get_col(board, &1)))

    Enum.any?(all_rows_cols, &Enum.all?(&1, fn {_, n} -> Enum.member?(numbers, n) end))
  end

  defp parse(args) do
    parts =
      args
      |> String.trim()
      |> String.split("\n\n")

    numbers = hd(parts) |> String.split(",") |> Enum.map(&String.to_integer/1)
    :logger.debug("#{inspect(numbers)}")

    boards =
      Enum.drop(parts, 1)
      |> Enum.map(&String.split(&1, "\n"))
      |> Enum.map(fn board_lines ->
        :logger.debug("#{inspect(board_lines)}")
        board_lines |> Enum.map(fn l -> String.split(l) |> Enum.map(&String.to_integer/1) end)
      end)
      |> Enum.map(&AdventOfCode.Day04.Board.create/1)

    {numbers, boards}
  end

  def part2(args) do
    {numbers, boards} = parse(args)

    {checked, winner} = get_last_bingo(numbers, boards)

    :logger.debug("checked: #{checked}")

    sum =
      winner.fields
      |> Enum.map(fn {_, v} -> v end)
      |> Enum.sum()

    :logger.debug("unmarked sum: #{sum}")
    checked * sum
  end

  # returns a tuple {winning_number, winning_board}
  defp get_last_bingo(open, boards) do
    [head | remaining] = open

    {bingo, non_bingo} =
      boards
      |> Enum.map(fn b ->
        cross_out(b, head)
      end)
      |> Enum.split_with(&is_bingo(&1))

    if Enum.empty?(non_bingo) do
      {head, hd(bingo)}
    else
      get_last_bingo(remaining, non_bingo)
    end
  end

  defp cross_out(board, value) do
    %{board | fields: :maps.filter(fn _, v -> v != value end, board.fields)}
  end

  defp is_bingo(board) do
    0..(board.width - 1)
    |> Enum.any?(&(Board.row_empty(board, &1) or Board.col_empty(board, &1)))
  end
end
