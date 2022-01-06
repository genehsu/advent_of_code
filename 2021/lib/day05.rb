# https://adventofcode.com/2021/day/5

class Day05

  class Grid
    def initialize(coords)
      @coords = coords
      max = @coords.map { |row| row.max }.max
      @size = max+1
      @grid = Array.new(@size) { Array.new(@size, 0) }
    end

    def draw_h
      @coords.each do |x1, y1, x2, y2|
        next unless y1 == y2
        x1, x2 = [x1, x2].sort
        (x1..x2).each do |x|
          @grid[x][y1] += 1
        end
      end
    end

    def draw_v
      @coords.each do |x1, y1, x2, y2|
        next unless x1 == x2
        y1, y2 = [y1, y2].sort
        (y1..y2).each do |y|
          @grid[x1][y] += 1
        end
      end
    end

    def draw_diag
      @coords.each do |x1, y1, x2, y2|
        next unless (x1 - x2).abs == (y1 - y2).abs
        if x1 > x2
          x1, x2, y1, y2 = x2, x1, y2, y1
        end
        direction = y2 <=> y1
        (x1..x2).each do |x|
          y = y1 + (x - x1) * direction
          @grid[x][y] += 1
        end
      end
    end

    def overlaps
      @grid.sum do |row|
        row.count { |cell| cell > 1 }
      end
    end

    def to_s
      @size.times do |y|
        @size.times do |x|
          print @grid[x][y] == 0 ? '.' : @grid[x][y]
        end
        puts
      end
    end

    def self.parse(input)
      coords = input.map do |line|
        /\A(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)\Z/ =~ line
        [x1, y1, x2, y2].map(&:to_i)
      end

      self.new(coords)
    end
  end

  def self.part1(input)
    grid = Grid.parse(input)
    grid.draw_h
    grid.draw_v
    grid.overlaps
  end

  def self.part2(input)
    grid = Grid.parse(input)
    grid.draw_h
    grid.draw_v
    grid.draw_diag
    grid.overlaps
  end
end
