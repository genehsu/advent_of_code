# Answer based on Jose Valim's stream
# I'm learning elixir

{_, input} = File.read("input/day02.txt") 

part1 = input
  |> String.split("\n", trim: true)
  |> Enum.reduce({_depth = 0, _position = 0}, fn
    "forward " <> number, {depth, position} -> {depth, position + String.to_integer(number)}
    "down " <> number, {depth, position} -> {depth + String.to_integer(number), position}
    "up " <> number, {depth, position} -> {depth - String.to_integer(number), position}
  end)
  |> then(fn {depth, position} -> depth * position end)

part2 = input
  |> String.split("\n", trim: true)
  |> Enum.reduce({_depth = 0, _position = 0, _aim = 0}, fn
    "forward " <> number, {depth, position, aim} ->
      number = String.to_integer(number)
      {depth + aim * number, position + number, aim}

    "down " <> number, {depth, position, aim} ->
      {depth, position, aim + String.to_integer(number)}

    "up " <> number, {depth, position, aim} ->
      {depth, position, aim - String.to_integer(number)}
  end)
  |> then(fn {depth, position, _aim} -> depth * position end)

defmodule Submarine do
  def navigate("forward " <> number, {depth, position, aim}) do
    number = String.to_integer(number)
    {depth + aim * number, position + number, aim}
  end

  def navigate("down " <> number, {depth, position, aim}) do
    {depth, position, aim + String.to_integer(number)}
  end

  def navigate("up " <> number, {depth, position, aim}) do
    {depth, position, aim - String.to_integer(number)}
  end
end

part2a = input
  |> String.split("\n", trim: true)
  |> Enum.reduce({_depth = 0, _position = 0, _aim = 0}, &Submarine.navigate/2)
  |> then(fn {depth, position, _aim} -> depth * position end)

IO.write("Part 1: ")
IO.puts(part1)
IO.write("Part 2: ")
IO.puts(part2)
IO.write("Part 2a:")
IO.puts(part2a)
