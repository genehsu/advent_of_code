# https://adventofcode.com/2022/day/4

class Day04
  def self.contains(range, other)
    range.cover?(other) || other.cover?(range)
  end

  def self.parse(line)
    line.split(/,/)
      .map { |spec| spec.split(/-/).map(&:to_i) }
      .map { |x,y| Range.new(x, y) }
  end

  def self.part1(input)
    input.count do |line|
      ranges = parse(line)
      contains(*ranges)
    end
  end

  def self.overlap(range, other)
    range.include?(other.begin) ||
      range.include?(other.end)
  end

  def self.part2(input)
    input.count do |line|
      ranges = parse(line)
      contains(*ranges) || overlap(*ranges)
    end
  end
end
