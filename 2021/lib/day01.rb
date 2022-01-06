# https://adventofcode.com/2021/day/1

class Day01
  def self.count_increasing(input, window_size)
    j = window_size
    count = 0
    input.each_with_index do |n, i|
      break if j == input.size
      m = input[j]
      count += 1 if m > n
      j += 1
    end
    count
  end

  def self.part1(input)
    count_increasing(input, 1)
  end

  def self.part2(input)
    count_increasing(input, 3)
  end
end
