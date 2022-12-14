# https://adventofcode.com/2022/day/13

class Day13
  def self.parse_pairs(input)
    i = 0
    pairs = {}
    while i < input.size
      left = eval(input[i])
      right = eval(input[i+1])
      i += 3
      pairs[i/3] = [left, right]
    end
    pairs
  end

  def self.parse_packets(input)
    packets = []
    0.step(by:3, to: input.size) do |i|
      packets << eval(input[i])
      packets << eval(input[i+1])
    end
    packets
  end

  def self.compare(pair)
    left, right = pair

    if left.is_a?(Integer) && right.is_a?(Integer)
      return left <=> right
    elsif left.is_a?(Array) && right.is_a?(Integer)
      return compare([left, Array[right]])
    elsif left.is_a?(Integer) && right.is_a?(Array)
      return compare([Array[left], right])
    end

    left.size.times do |i|
      return 1 if right[i].nil?

      result = compare([left[i], right[i]])
      return result if result != 0
    end

    left.size < right.size ? -1 : 0
  end

  def self.part1(input)
    pairs = parse_pairs(input)
    pairs.select { |k,pair| compare(pair) < 0 }
      .keys
      .sum
  end

  def self.part2(input)
    packets = parse_packets(input)
    packets << [[2]]
    packets << [[6]]
    packets.sort! { |a, b| compare([a,b]) }
    two = packets.index([[2]]) + 1
    six = packets.index([[6]]) + 1
    two * six
  end
end
