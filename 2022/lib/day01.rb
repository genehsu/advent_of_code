# https://adventofcode.com/2022/day/1

class Day01
  def self.grouped_sums(input)
    sums = [].tap do |sums|
      current = 0
      input.each do |line|
        if line == ''
          sums << current
          current = 0
        else
          current += line.to_i
        end
      end
      sums << current
    end
  end

  def self.part1(input)
    grouped_sums(input).max
  end

  def self.part2(input)
    grouped_sums(input).sort!.last(3).sum
  end
end
