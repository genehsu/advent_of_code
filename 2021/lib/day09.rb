# https://adventofcode.com/2021/day/9

class Day09

  def initialize(input)
    parse input
  end

  def parse(input)
    @area = input.map do |line|
      [9, line.split(//).map(&:to_i), 9].flatten
    end
    border_row = Array.new(@area.first.size, 9)
    @area = [border_row, *@area, border_row]
  end

  def min_adjacent(x, y)
    [
            @area[x][y-1],
      @area[x-1][y], @area[x+1][y],
            @area[x][y+1],
    ].min
  end

  def sum_low_points
    sum = 0
    @area.each_with_index do |row, x|
      next if x == 0 or x == @area.size - 1
      row.each_with_index do |cell, y|
        next if y == 0 or y == row.size - 1
        sum += cell + 1 if cell < min_adjacent(x, y)
      end
    end
    sum
  end

  def self.part1(input)
    area = new input
    area.sum_low_points
  end

  def basin_size(x, y)
    stack = [[x,y]]
    size =  0
    while (x,y = stack.pop)
      next if @area[x][y] == 9
      size += 1
      @area[x][y] = 9 # set to 9 to indicate the cell has been visited
      [[x+1,y],
       [x-1,y],
       [x,y+1],
       [x,y-1],
      ].each do |x1,y1|
        stack << [x1,y1] unless @area[x1][y1] == 9
      end
    end
    size
  end

  def get_basin_sizes
    basins = []
    @area.each_with_index do |row, x|
      next if x == 0 or x == @area.size - 1
      row.each_with_index do |cell, y|
        next if y == 0 or y == row.size - 1
        if cell < 9
          basins << basin_size(x, y)
        end
      end
    end
    basins
  end

  def self.part2(input)
    area = new input
    basins = area.get_basin_sizes
    basins.sort[-3,3].reduce(&:*)
  end
end
