defmodule AdventOfCode do
  @moduledoc """
  Documentation for AdventOfCode.
  """

  defmodule ExecutionTime do
    def time_of(function) do
      {time, _result} = :timer.tc(function)
      IO.puts("Time: #{time / 1000}ms")
    end
  end
end
