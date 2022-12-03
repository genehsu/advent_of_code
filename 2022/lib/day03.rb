# https://adventofcode.com/2022/day/3

class Day03
  PRIORITY = ('a'..'z').chain('A'..'Z').each.with_index.map {|x,i| [x, i+1] }.to_h.freeze

  def self.find_duplicates(input)
    len = input.length
    chamber1 = input[0...len/2].split(//)
    chamber2 = input[len/2...len].split(//)
    chamber1.intersection(chamber2).tap do |dups|
      #p dups
    end.first
  end

  def self.part1(input)
    input.map do |line|
      PRIORITY[find_duplicates(line)]
    end.sum
  end

  def self.part2(input)
    sum = 0
    input.each_slice(3) do |triple|
      first = triple[0].split(//)
      second = triple[1].split(//)
      third = triple[2].split(//)
      common = first.intersection(second, third).first
      sum += PRIORITY[common]
    end
    sum
  end
end
