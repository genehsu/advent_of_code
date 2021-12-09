def read_inputs(input)
  line = input.shift
  line.split(/,/).map(&:to_i)
end

def read_board(input)
  board = []
  input.shift
  5.times do
    line = input.shift
    board << line.split(/ +/).map(&:to_i)
  end
  board
end

def win_on(board, inputs)
  board_state = Array.new(5) { Array.new(5, false) }
  inputs.each_with_index do |n, i|
    board.size.times do |x|
      board.size.times do |y|
        next unless board[x][y] == n
        board_state[x][y] = true
      end
    end
    if win? board_state
      return i, score(n, board, board_state)
    end
  end
  return [inputs.size, 0]
end

def win?(board_state)
  board_state.any? do |row|
    row.all? { |square| square }
  end || board_state.transpose.any? do |column|
    column.all? { |square| square }
  end
end

def score(n, board, board_state)
  unused = []
  board.size.times do |x|
    board.size.times do |y|
      unused << board[x][y] unless board_state[x][y]
    end
  end
  unused.sum * n
end

def score_4a(input)
  inputs = read_inputs(input)
  boards = []
  while input.size > 0
    boards << read_board(input)
  end
  sorted = boards.sort_by { |b| win_on(b, inputs).first }
  win_on(sorted.first, inputs)[1]
end

def score_4b(input)
  inputs = read_inputs(input)
  boards = []
  while input.size > 0
    boards << read_board(input)
  end
  sorted = boards.sort_by { |b| win_on(b, inputs).first }
  win_on(sorted.last, inputs)[1]
end
