# https://adventofcode.com/2021/day/17

class Day17

  def initialize(x_range, y_range)
    @x_range = x_range
    @y_range = y_range
  end

  def shoot(dx, dy)
    x, y = 0, 0
    max_y = y
    hit = false
    right = @x_range.end
    bottom = @y_range.begin

    while y >= bottom && x <= right
      x += dx
      y += dy
      max_y = [y, max_y].max
      hit = @x_range.include?(x) && @y_range.include?(y)
      break if hit
      dx -= 1 if dx > 0
      dy -= 1
    end

    hit ? max_y :
      dx == 0 && x < @x_range.begin ? -1 : # cannot reach the target
      y >= bottom && x > right ? -2 : # overshot the target
      -3 # generic target miss
  end

  def explore
    max_y = 0
    count = 0
    (1..@x_range.end).each do |dx|
      (@y_range.begin..@y_range.begin.abs).each do |dy|
        try = shoot(dx, dy)
        count += 1 if try >= 0
        break if try == -1 || try == -2
        max_y = [max_y, try].max
      end
    end
    @count = count
    @max_y = max_y
  end

  def max_y
    @max_y
  end

  def hit_count
    @count
  end

  def self.parse(input)
    /^target area: x=(?<x1>\d+)..(?<x2>\d+), y=(?<y1>-?\d+)..(?<y2>-?\d+)/ =~ input
    new x1.to_i..x2.to_i, y1.to_i..y2.to_i
  end

  def self.part1(input)
    target = parse input
    target.explore
    target.max_y
  end

  def self.part2(input)
    target = parse input
    target.explore
    target.hit_count
  end
end
