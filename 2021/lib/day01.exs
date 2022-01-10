# Answer based on Jose Valim's stream
# I'm learning elixir

{_, input} = File.read("input/day01.txt")

part1 = input
|> String.splitter("\n", trim: true)
|> Stream.map(&String.to_integer/1)
|> Stream.chunk_every(2, 1, :discard)
|> Enum.count(fn [left, right] -> right > left end)

part2 = input
|> String.splitter("\n", trim: true)
|> Stream.map(&String.to_integer/1)
|> Stream.chunk_every(4, 1, :discard)
|> Enum.count(fn [left, _, _, right] -> right > left end)

IO.write("Part 1: ")
IO.puts(part1)
IO.write("Part 2: ")
IO.puts(part2)
