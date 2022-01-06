# https://adventofcode.com/2021/day/11

class Day11

  class Grid
    attr_reader :flashes, :steps

    def initialize(data)
      @data = data
      @flashes = 0
      @steps = 0
      # create a grid to keep track of flashes
      # with 2 extra rows/and columns
      # so that I don't have to keep track of edges
      @f_grid = (1..size+2).map { |row| Array.new(size+2, 0) }
    end

    def self.parse(input)
      data = input.map { |row| row.split(//).map(&:to_i) }
      self.new(data)
    end

    def increment
      size.times do |y|
        size.times do |x|
          @data[y][x] += 1
        end
      end
    end

    def step
      @steps += 1
      increment
      current_flashes = -1
      while current_flashes < flashes
        current_flashes = flashes
        reset_f_grid
        register_flashes
        apply_flashes
      end
    end

    def size
      @data.size
    end

    def octopuses
      @octopuses ||= size * size
    end

    def register_flashes
      size.times do |y|
        size.times do |x|
          flash(x,y) if @data[y][x] > 9
        end
      end
    end

    def apply_flashes
      size.times do |y|
        size.times do |x|
          @data[y][x] += @f_grid[y+1][x+1] if @data[y][x] > 0
        end
      end
    end

    def flash(x,y)
      fx = x+1
      fy = y+1
      @flashes += 1
      @f_grid[fy-1][fx-1] += 1; @f_grid[fy-1][fx] += 1; @f_grid[fy-1][fx+1] += 1
      @f_grid[fy  ][fx-1] += 1;                       ; @f_grid[fy  ][fx+1] += 1
      @f_grid[fy+1][fx-1] += 1; @f_grid[fy+1][fx] += 1; @f_grid[fy+1][fx+1] += 1
      @data[y][x] = 0
    end

    def reset_f_grid
      (size+2).times do |y|
        (size+2).times do |x|
          @f_grid[y][x] = 0
        end
      end
    end

    def to_s
      @data.map do |row|
        row.join('')
      end.join("\n")
    end
  end

  def self.part1(input)
    grid = Grid.parse input
    100.times { grid.step }
    grid.flashes
  end

  def self.part2(input)
    grid = Grid.parse input
    flashes = 0
    while grid.flashes - flashes < grid.octopuses
      flashes = grid.flashes
      grid.step
    end
    grid.steps
  end

end
