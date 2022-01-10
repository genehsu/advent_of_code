# Answer based on Jose Valim's stream
# I'm learning elixir

use Bitwise, only_operators: true

{_, input} = File.read("input/day03.txt")

numbers =
  input
  |> String.split("\n", trim: true)
  |> Enum.map(&(&1 |> String.to_charlist() |> List.to_tuple()))

[sample | _] = numbers
digit_count = tuple_size(sample)
half = div(length(numbers), 2)

gamma =
  for i <- 0..(digit_count - 1) do
    ones = Enum.count(numbers, &(elem(&1, i) == ?1))
    if ones > half, do: ?1, else: ?0
  end
  |> List.to_integer(2)

bitmask = (1 <<< digit_count) - 1
epsilon = ~~~gamma &&& bitmask
part1 = gamma * epsilon

defmodule Recursion do
  defp recur([number], _pos, _fx) do
    number
    |> Tuple.to_list()
    |> List.to_integer(2)
  end

  defp recur(numbers, pos, fx) do
    ones = Enum.count(numbers, &(elem(&1, pos) == ?1))
    zeroes = length(numbers) - ones
    target = fx.(zeroes, ones)
    numbers = Enum.filter(numbers, &(elem(&1, pos) == target))
    recur(numbers, pos + 1, fx)
  end

  def o2(numbers) do
    recur(numbers, 0, fn zeroes, ones ->
      if zeroes > ones, do: ?0, else: ?1
    end)
  end

  def co2(numbers) do
    recur(numbers, 0, fn zeroes, ones ->
      if zeroes > ones, do: ?1, else: ?0
    end)
  end
end

part2 = Recursion.o2(numbers) * Recursion.co2(numbers)

IO.write("Part 1: ")
IO.puts(part1)
IO.write("Part 2: ")
IO.puts(part2)
