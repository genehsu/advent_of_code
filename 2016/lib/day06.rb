# https://adventofcode.com/2016/day/6

class Day06
  def self.part1(input)
    answer = []
    input.first.size.times do |i|
      answer << input.map { |line| line[i] }.tally.max_by { |k,v| v }[0]
    end
    answer.join('')
  end

  def self.part2(input)
    answer = []
    input.first.size.times do |i|
      answer << input.map { |line| line[i] }.tally.min_by { |k,v| v }[0]
    end
    answer.join('')
  end
end
