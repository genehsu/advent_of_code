# https://adventofcode.com/2015/day/12

require 'json'

class Day12

  def self.part1(input)
    total = 0
    input.split(/[^\d-]+/).each do |num|
      total += num.to_i
    end
    total
  end

  def self.object_sum(object)
    case object
    when Array
      object.map { |o| object_sum o }.sum
    when Numeric
      object
    when Hash
      return 0 if object.values.include? "red"
      object.values.map { |o| object_sum o }.sum
    else
      0
    end
  end

  def self.part2(input)
    object = JSON.parse input
    object_sum(object)
  end
end
