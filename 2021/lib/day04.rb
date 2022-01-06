# https://adventofcode.com/2021/day/4

class Day04

  class Bingo
    attr_reader :board
    def initialize(board, numbers)
      @board = board
      @numbers = numbers
      @board_state = Array.new(5) { Array.new(5, false) }
      @board_lookup = generate_lookup
      @score = 0
    end

    def generate_lookup
      {}.tap do |lookup|
        board.size.times do |x|
          board.size.times do |y|
            lookup[board[x][y]] = [x, y]
          end
        end
      end
    end

    def lookup(n)
      @board_lookup[n]
    end

    def mark(x, y)
      @board_state[x][y] = true
    end

    def unused_squares
      [].tap do |unused|
        board.size.times do |x|
          board.size.times do |y|
            unused << board[x][y] unless @board_state[x][y]
          end
        end
      end
    end

    def win?
      win_by_row? || win_by_column?
    end

    def win_by_row?
      @board_state.any? do |row|
        row.all? { |square| square }
      end
    end

    def win_by_column?
      @board_state.transpose.any? do |column|
        column.all? { |square| square }
      end
    end

    def win_on
      @win_on ||= calc_win_index
    end

    def calc_win_index
      @numbers.each_with_index do |n, i|
        next unless lookup(n)
        mark *lookup(n)
        if win?
          set_score n
          return i
        end
      end
      inputs.size
    end

    def set_score(n)
      @score = unused_squares.sum * n
    end

    def score
      @score
    end
  end

  def self.parse_inputs(input)
    inputs = read_inputs(input)
    boards = []
    while input.size > 0
      boards << read_board(input)
    end
    boards.map { |b| Bingo.new b, inputs }
  end

  def self.read_inputs(input)
    line = input.shift
    line.split(/,/).map(&:to_i)
  end

  def self.read_board(input)
    board = []
    input.shift
    5.times do
      line = input.shift
      board << line.split(/ +/).map(&:to_i)
    end
    board
  end

  def self.part1(input)
    boards = parse_inputs(input)
    sorted = boards.sort_by { |b| b.win_on }
    sorted.first.score
  end

  def self.part2(input)
    boards = parse_inputs(input)
    sorted = boards.sort_by { |b| b.win_on }
    sorted.last.score
  end
end
