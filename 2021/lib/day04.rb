# https://adventofcode.com/2021/day/4
# --- Day 4: Giant Squid ---

class Day04
  # You're already almost 1.5km (almost a mile) below the surface of the ocean,
  # already so deep that you can't see any sunlight. What you can see, however,
  # is a giant squid that has attached itself to the outside of your submarine.
  #
  # Maybe it wants to play bingo?
  #
  # Bingo is played on a set of boards each consisting of a 5x5 grid of
  # numbers. Numbers are chosen at random, and the chosen number is marked on
  # all boards on which it appears. (Numbers may not appear on all boards.) If
  # all numbers in any row or any column of a board are marked, that board
  # wins. (Diagonals don't count.)
  #
  # The submarine has a bingo subsystem to help passengers (currently, you and
  # the giant squid) pass the time. It automatically generates a random order
  # in which to draw numbers and a random set of boards (your puzzle input).
  # For example:
  #
  # 7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1
  #
  # 22 13 17 11  0
  #  8  2 23  4 24
  # 21  9 14 16  7
  #  6 10  3 18  5
  #  1 12 20 15 19
  #
  #  3 15  0  2 22
  #  9 18 13 17  5
  # 19  8  7 25 23
  # 20 11 10 24  4
  # 14 21 16 12  6
  #
  # 14 21 17 24  4
  # 10 16 15  9 19
  # 18  8 23 26 20
  # 22 11 13  6  5
  #  2  0 12  3  7
  #
  # After the first five numbers are drawn (7, 4, 9, 5, and 11), there are no
  # winners, but the boards are marked as follows (shown here adjacent to each
  # other to save space):
  #
  # 22 13 17 11  0         3 15  0  2 22        14 21 17 24  4
  #  8  2 23  4 24         9 18 13 17  5        10 16 15  9 19
  # 21  9 14 16  7        19  8  7 25 23        18  8 23 26 20
  #  6 10  3 18  5        20 11 10 24  4        22 11 13  6  5
  #  1 12 20 15 19        14 21 16 12  6         2  0 12  3  7
  #
  # After the next six numbers are drawn (17, 23, 2, 0, 14, and 21), there are
  # still no winners:
  #
  # 22 13 17 11  0         3 15  0  2 22        14 21 17 24  4
  #  8  2 23  4 24         9 18 13 17  5        10 16 15  9 19
  # 21  9 14 16  7        19  8  7 25 23        18  8 23 26 20
  #  6 10  3 18  5        20 11 10 24  4        22 11 13  6  5
  #  1 12 20 15 19        14 21 16 12  6         2  0 12  3  7
  #
  # Finally, 24 is drawn:
  #
  # 22 13 17 11  0         3 15  0  2 22        14 21 17 24  4
  #  8  2 23  4 24         9 18 13 17  5        10 16 15  9 19
  # 21  9 14 16  7        19  8  7 25 23        18  8 23 26 20
  #  6 10  3 18  5        20 11 10 24  4        22 11 13  6  5
  #  1 12 20 15 19        14 21 16 12  6         2  0 12  3  7
  #
  # At this point, the third board wins because it has at least one complete
  # row or column of marked numbers (in this case, the entire top row is
  # marked: 14 21 17 24 4).
  #
  # The score of the winning board can now be calculated. Start by finding the
  # sum of all unmarked numbers on that board; in this case, the sum is 188.
  # Then, multiply that sum by the number that was just called when the board
  # won, 24, to get the final score, 188 * 24 = 4512.
  #
  # To guarantee victory against the giant squid, figure out which board will
  # win first. What will your final score be if you choose that board?

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

  # On the other hand, it might be wise to try a different strategy: let the
  # giant squid win.
  #
  # You aren't sure how many bingo boards a giant squid could play at once, so
  # rather than waste time counting its arms, the safe thing to do is to figure
  # out which board will win last and choose that one. That way, no matter
  # which boards it picks, it will win for sure.
  #
  # In the above example, the second board is the last to win, which happens
  # after 13 is eventually called and its middle column is completely marked.
  # If you were to keep playing until this point, the second board would have a
  # sum of unmarked numbers equal to 148 for a final score of 148 * 13 = 1924.
  #
  # Figure out which board will win last. Once it wins, what would its final
  # score be?

  def self.part2(input)
    boards = parse_inputs(input)
    sorted = boards.sort_by { |b| b.win_on }
    sorted.last.score
  end
end
