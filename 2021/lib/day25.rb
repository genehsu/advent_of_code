# https://adventofcode.com/2021/day/25

class Day25

  class FieldOfCucumbers
    attr_reader :steps

    EMPTY = '.'.freeze
    EAST = '>'.freeze
    SOUTH = 'v'.freeze

    def initialize(input)
      @grid = input
      @steps = 0
      @moves = @grid.size * @grid[0].size
    end

    def move
      @moves = 0
      @grid = move_east
      @grid = move_south
      @steps += 1
      @moves > 0
    end

    def move_east
      new_grid = @grid.map(&:dup)
      @grid.each_with_index do |line, i|
        if line[0] == EMPTY && line[-1] == EAST
          @moves += 1
          new_grid[i][0] = EAST
          new_grid[i][-1] = EMPTY
        end
        (1...line.size).each do |j|
          next unless line[j] == EMPTY
          next unless line[j-1] == EAST
          @moves += 1
          new_grid[i][j-1] = EMPTY
          new_grid[i][j] = EAST
        end
      end
      new_grid
    end

    def move_south
      new_grid = @grid.map(&:dup)
      line = @grid[0]
      (0...line.size).each do |j|
        if @grid[0][j] == EMPTY && @grid[-1][j] == SOUTH
          @moves += 1
          new_grid[0][j] = SOUTH
          new_grid[-1][j] = EMPTY
        end
        (1...@grid.size).each do |i|
          next unless @grid[i][j] == EMPTY
          next unless @grid[i-1][j] == SOUTH
          @moves += 1
          new_grid[i][j] = SOUTH
          new_grid[i-1][j] = EMPTY
        end
      end
      new_grid
    end

    def to_s
      @grid.join("\n")
    end
  end

  def self.part1(input)
    field = FieldOfCucumbers.new input
    while field.move
      #puts field
      #puts
    end
    field.steps
  end
end
