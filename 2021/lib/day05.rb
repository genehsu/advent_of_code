# https://adventofcode.com/2021/day/5
# --- Day 5: Hydrothermal Venture ---

class Day05
  # You come across a field of hydrothermal vents on the ocean floor! These
  # vents constantly produce large, opaque clouds, so it would be best to avoid
  # them if possible.
  #
  # They tend to form in lines; the submarine helpfully produces a list of
  # nearby lines of vents (your puzzle input) for you to review. For example:
  #
  # 0,9 -> 5,9
  # 8,0 -> 0,8
  # 9,4 -> 3,4
  # 2,2 -> 2,1
  # 7,0 -> 7,4
  # 6,4 -> 2,0
  # 0,9 -> 2,9
  # 3,4 -> 1,4
  # 0,0 -> 8,8
  # 5,5 -> 8,2
  #
  # Each line of vents is given as a line segment in the format x1,y1 -> x2,y2
  # where x1,y1 are the coordinates of one end the line segment and x2,y2 are
  # the coordinates of the other end. These line segments include the points at
  # both ends. In other words:
  #
  #     An entry like 1,1 -> 1,3 covers points 1,1, 1,2, and 1,3.
  #     An entry like 9,7 -> 7,7 covers points 9,7, 8,7, and 7,7.
  #
  # For now, only consider horizontal and vertical lines: lines where either x1
  # = x2 or y1 = y2.
  #
  # So, the horizontal and vertical lines from the above list would produce the
  # following diagram:
  #
  # .......1..
  # ..1....1..
  # ..1....1..
  # .......1..
  # .112111211
  # ..........
  # ..........
  # ..........
  # ..........
  # 222111....
  #
  # In this diagram, the top left corner is 0,0 and the bottom right corner is
  # 9,9. Each position is shown as the number of lines which cover that point
  # or . if no line covers that point. The top-left pair of 1s, for example,
  # comes from 2,2 -> 2,1; the very bottom row is formed by the overlapping
  # lines 0,9 -> 5,9 and 0,9 -> 2,9.
  #
  # To avoid the most dangerous areas, you need to determine the number of
  # points where at least two lines overlap. In the above example, this is
  # anywhere in the diagram with a 2 or larger - a total of 5 points.
  #
  # Consider only horizontal and vertical lines. At how many points do at least
  # two lines overlap?

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

  def overlaps
    @grid.sum do |line|
      line && line.count { |cell| cell && cell > 1 } || 0
    end
  end

  def to_s
    @size.times do |y|
      @size.times do |x|
        print field[x][y] == 0 ? '.' : field[x][y]
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

  def self.part1(input)
    grid = parse(input)
    grid.draw_h
    grid.draw_v
    grid.overlaps
  end

  # Unfortunately, considering only horizontal and vertical lines doesn't give
  # you the full picture; you need to also consider diagonal lines.
  #
  # Because of the limits of the hydrothermal vent mapping system, the lines in
  # your list will only ever be horizontal, vertical, or a diagonal line at
  # exactly 45 degrees. In other words:
  #
  #     An entry like 1,1 -> 3,3 covers points 1,1, 2,2, and 3,3.
  #     An entry like 9,7 -> 7,9 covers points 9,7, 8,8, and 7,9.
  #
  # Considering all lines from the above example would now produce the
  # following diagram:
  #
  # 1.1....11.
  # .111...2..
  # ..2.1.111.
  # ...1.2.2..
  # .112313211
  # ...1.2....
  # ..1...1...
  # .1.....1..
  # 1.......1.
  # 222111....
  #
  # You still need to determine the number of points where at least two lines
  # overlap. In the above example, this is still anywhere in the diagram with a
  # 2 or larger - now a total of 12 points.
  #
  # Consider all of the lines. At how many points do at least two lines
  # overlap?
  #
  # Your puzzle answer was 16925.

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

  def self.part2(input)
    grid = parse(input)
    grid.draw_h
    grid.draw_v
    grid.draw_diag
    grid.overlaps
  end
end
