# Answer based on Jose Valim's stream
# I'm learning elixir

defmodule Input do
  def input do
    {_, data} = File.read("input/day04.txt")
    data
    |> String.split("\n", trim: true)
  end

  def numbers do
    [numbers | _] = input()
    numbers
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def grids do
    [_ | grids] = input()
    grids
  end

  def boards do
    grids()
    |> Enum.chunk_every(5)
    |> Enum.map(fn rows ->
      Board.new(
        for {line, row} <- Enum.with_index(rows, 0),
            {number, col} <- Enum.with_index(String.split(line), 0),
            into: %{} do
          {String.to_integer(number), {row, col}}
        end
      )
    end)
  end
end

defmodule Board do
  empty_board = Tuple.duplicate(Tuple.duplicate(false, 5), 5)
  @enforce_keys [:numbers]
  defstruct numbers: %{}, grid: empty_board

  def new(numbers) when is_map(numbers) do
    %Board{numbers: numbers}
  end

  def mark(%Board{numbers: numbers} = board, number) do
    case numbers do
      %{^number => {row, col}} ->
        put_in(board, [Access.key(:grid), Access.elem(row), Access.elem(col)], true)

      %{} ->
        board
    end
  end

  def unmarked_sum(%Board{numbers: numbers, grid: grid}) do
    Enum.sum(
      for {number, {row, col}} <- numbers,
          grid |> elem(row) |> elem(col) == false,
          do: number
    )
  end

  def won?(%Board{grid: grid}) do
    row_won?(grid) or column_won?(grid)
  end

  defp column_won?(grid) do
    Enum.any?(0..4, fn col ->
      Enum.all?(0..4, fn row -> grid |> elem(row) |> elem(col) end)
    end)
  end

  defp row_won?(grid) do
    Enum.any?(0..4, fn row ->
      elem(grid, row) == {true, true, true, true, true}
    end)
  end
end

defmodule Part1 do
  def answer do
    {number, board = %Board{}} =
      Enum.reduce_while(Input.numbers, Input.boards, fn number, boards ->
        boards = Enum.map(boards, &Board.mark(&1, number))

        if board = Enum.find(boards, &Board.won?/1) do
          {:halt, {number, board}}
        else
          {:cont, boards}
        end
      end)

    number * Board.unmarked_sum(board)
  end
end

defmodule Part2 do
  def answer do
    {number, board = %Board{}} =
      Enum.reduce_while(Input.numbers, Input.boards, fn number, boards ->
        boards = Enum.map(boards, &Board.mark(&1, number))

        case Enum.reject(boards, &Board.won?/1) do
          [] ->
            # We can assume there was only one board left,
            # otherwise AoC gave me a bad input.
            [board] = boards
            {:halt, {number, board}}

          boards ->
            {:cont, boards}
        end
      end)

    number * Board.unmarked_sum(board)
  end
end


IO.write("Part 1: ")
IO.puts(Part1.answer)
IO.write("Part 2: ")
IO.puts(Part2.answer)
