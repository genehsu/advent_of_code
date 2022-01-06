# https://adventofcode.com/2021/day/7

class Day07
  def self.cumulative_difference(input, anchor)
    input.sum { |n| (n - anchor).abs }
  end

  def self.part1(input)
    a = input.min
    b = input.max
    (a..b).map do |n|
      cumulative_difference(input, n)
    end.min
  end

  def self.part1a(input)
    sorted = input.sort
    cumulative_difference(input, sorted[sorted.size/2])
  end

  def self.cumulative_difference_expensive(input, anchor)
    input.sum { |n| d = (n - anchor).abs; d * (d+1) / 2 }
  end

  def self.part2(input)
    a = input.min
    b = input.max
    (a..b).map do |n|
      cumulative_difference_expensive(input, n)
    end.min
  end

  def self.part2a(input)
    average = input.sum / input.size
    (average-1..average+1).map do |n|
      cumulative_difference_expensive(input, n)
    end.min
  end
end
