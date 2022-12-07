# https://adventofcode.com/2022/day/6

class Day06
  def self.find_first_different_substring(input, char_count)
    tally = Hash.new(0)
    input.each_char.with_index do |c,i|
      tally[c] += 1
      if i - char_count >= 0
        old_c = input[i-char_count]
        tally[old_c] -= 1
        tally.delete(old_c) if tally[old_c] == 0
      end
      return i+1 if tally.keys.size == char_count
    end
  end

  def self.part1(input)
    find_first_different_substring(input, 4)
  end

  def self.part2(input)
    find_first_different_substring(input, 14)
  end
end
