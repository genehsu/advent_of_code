# https://adventofcode.com/2021/day/9
# --- Day 9: Smoke Basin ---

class Day09
  # These caves seem to be lava tubes. Parts are even still volcanically
  # active; small hydrothermal vents release smoke into the caves that slowly
  # settles like rain.
  #
  # If you can model how the smoke flows through the caves, you might be able
  # to avoid it and be that much safer. The submarine generates a heightmap of
  # the floor of the nearby caves for you (your puzzle input).
  #
  # Smoke flows to the lowest point of the area it's in. For example, consider
  # the following heightmap:
  #
  # 2199943210
  # 3987894921
  # 9856789892
  # 8767896789
  # 9899965678
  #
  # Each number corresponds to the height of a particular location, where 9 is
  # the highest and 0 is the lowest a location can be.
  #
  # Your first goal is to find the low points - the locations that are lower
  # than any of its adjacent locations. Most locations have four adjacent
  # locations (up, down, left, and right); locations on the edge or corner of
  # the map have three or two adjacent locations, respectively. (Diagonal
  # locations do not count as adjacent.)
  #
  # In the above example, there are four low points, all highlighted: two are
  # in the first row (a 1 and a 0), one is in the third row (a 5), and one is
  # in the bottom row (also a 5). All other locations on the heightmap have
  # some lower adjacent location, and so are not low points.
  #
  # The risk level of a low point is 1 plus its height. In the above example,
  # the risk levels of the low points are 2, 1, 6, and 6. The sum of the risk
  # levels of all low points in the heightmap is therefore 15.
  #
  # Find all of the low points on your heightmap. What is the sum of the risk
  # levels of all low points on your heightmap?

  def initialize(input)
    parse input
  end

  def parse(input)
    @area = []
    input.each do |line|
      row = line.split(//).map(&:to_i)
      row.unshift 9
      row << 9
      @area << row
    end
    border_row = Array.new(@area.first.size, 9)
    @area.unshift border_row
    @area << border_row
  end

  def sum_low_points
    sum = 0
    @area.each_with_index do |row, x|
      next if x == 0 or x == @area.size - 1
      row.each_with_index do |cell, y|
        next if y == 0 or y == row.size - 1
        min_adjacent = [
          @area[x+1][y],
          @area[x-1][y],
          @area[x][y+1],
          @area[x][y-1]
        ].min
        sum += cell + 1 if cell < min_adjacent
      end
    end
    sum
  end

  def self.part1(input)
    area = new input
    return area.sum_low_points
  end

  # Next, you need to find the largest basins so you know what areas are most
  # important to avoid.
  #
  # A basin is all locations that eventually flow downward to a single low
  # point. Therefore, every low point has a basin, although some basins are
  # very small. Locations of height 9 do not count as being in any basin, and
  # all other locations will always be part of exactly one basin.
  #
  # The size of a basin is the number of locations within the basin, including
  # the low point. The example above has four basins.
  #
  # The top-left basin, size 3:
  #
  # 2199943210
  # 3987894921
  # 9856789892
  # 8767896789
  # 9899965678
  #
  # The top-right basin, size 9:
  #
  # 2199943210
  # 3987894921
  # 9856789892
  # 8767896789
  # 9899965678
  #
  # The middle basin, size 14:
  #
  # 2199943210
  # 3987894921
  # 9856789892
  # 8767896789
  # 9899965678
  #
  # The bottom-right basin, size 9:
  #
  # 2199943210
  # 3987894921
  # 9856789892
  # 8767896789
  # 9899965678
  #
  # Find the three largest basins and multiply their sizes together. In the
  # above example, this is 9 * 14 * 9 = 1134.
  #
  # What do you get if you multiply together the sizes of the three largest
  # basins?
  #
  # Your puzzle answer was 1075536.

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
    return basins.sort[-3,3].reduce(&:*)
  end
end
