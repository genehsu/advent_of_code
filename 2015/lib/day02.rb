# https://adventofcode.com/2015/day/2

class Day02

  def self.part1(input)
    total = 0
    input.each do |line|
      l, w, h = line.split('x').map(&:to_i)
      areas = [l*w, l*h, w*h].sort
      sum = areas.sum * 2 + areas.first
      total += sum
    end
    total
  end

  def self.part2(input)
    total = 0
    input.each do |line|
      l, w, h = line.split('x').map(&:to_i)
      dimensions = [l, w, h].sort
      sum = (dimensions[0] + dimensions [1]) * 2 + l*w*h
      total += sum
    end
    total
  end
end
