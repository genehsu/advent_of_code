# https://adventofcode.com/2016/day/3

class Day03
  def self.possible_triangle?(side)
    side = side.sort
    side[0] > side[2] - side[1]
  end

  def self.parse_line(line)
    line.split(/\s+/)
      .select { |s| s =~ /\d/ }
      .map(&:to_i)
  end

  def self.part1(input)
    input.count do |line|
      side = parse_line line
      possible_triangle? side
    end
  end

  def self.part2(input)
    input
      .map { |line| parse_line line }
      .each_slice(3).map do |lines|
        lines
          .transpose
          .count { |side| possible_triangle? side }
      end.sum
  end
end
