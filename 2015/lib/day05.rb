# https://adventofcode.com/2015/day/5

class Day05

  def self.part1(input)
    count = 0
    input.each do |line|
      next unless line =~ /[aeiou].*[aeiou].*[aeiou]/
      next unless line =~ /([a-z])\1/
      next if line =~ /ab|cd|pq|xy/
      count += 1
    end

    count
  end

  def self.part2(input)
    count = 0
    input.each do |line|
      next unless line =~ /([a-z]{2}).*\1/
      next unless line =~ /([a-z]).\1/
      count += 1
    end

    count
  end
end
