# https://adventofcode.com/2022/day/8

class Day08
  class Grid
    attr_reader :grid, :x_min, :y_min, :x_max, :y_max

    def initialize(grid)
      @grid = grid.map { |line| line.split(//).map(&:to_i) }
      @x_min = @y_min = 0
      @x_max = @grid[0].size-1
      @y_max = @grid.size-1
    end

    def count_visible
      count = 0
      visible = @grid.map do |line|
        ' ' * line.length
      end

      (0...@grid.size).each do |y|
        line = @grid[y]
        last = -1
        (0...line.size).each do |x|
          cell = line[x]
          if cell > last
            last = cell
            count += 1 if visible[y][x] != '*'
            visible[y][x] = '*'
          end
        end
        last = -1
        (line.size-1).downto(0) do |x|
          cell = line[x]
          if cell > last
            last = cell
            count += 1 if visible[y][x] != '*'
            visible[y][x] = '*'
          end
        end
      end
      line = @grid[0]
      (0...line.size).each do |x|
        last = -1
        (0...@grid.size).each do |y|
          cell = @grid[y][x]
          if cell > last
            last = cell
            count += 1 if visible[y][x] != '*'
            visible[y][x] = '*'
          end
        end
        last = -1
        (@grid.size-1).downto(0) do |y|
          cell = @grid[y][x]
          if cell > last
            last = cell
            count += 1 if visible[y][x] != '*'
            visible[y][x] = '*'
          end
        end
      end
      count
    end

    def max_scenic_score
      max = 0
      (y_min..y_max).each do |y|
        (x_min..x_max).each do |x|
          max = [max, scenic_score(x,y)].max
        end
      end
      max
    end

    def scenic_score(x, y)
      return 0 if x == x_min || y == y_min ||
        x == x_max || y == y_max

      score = 1

      (x-1).downto(x_min) do |z|
        if z == x_min || @grid[y][x] <= @grid[y][z]
          score *= x-z
          break
        end
      end

      (y-1).downto(y_min) do |z|
        if z == y_min || @grid[y][x] <= @grid[z][x]
          score *= y-z
          break
        end
      end

      (y+1).upto(y_max) do |z|
        if z == y_max || @grid[y][x] <= @grid[z][x]
          score *= z-y
          break
        end
      end

      (x+1).upto(x_max) do |z|
        if z == x_max || @grid[y][x] <= @grid[y][z]
          score *= z-x
          break
        end
      end

      score
    end
  end

  def self.part1(input)
    grid = Grid.new(input)
    grid.count_visible
  end

  def self.part2(input)
    grid = Grid.new(input)
    grid.max_scenic_score
  end
end
