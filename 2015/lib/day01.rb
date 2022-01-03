# https://adventofcode.com/2015/day/1

class Day01
  def self.part1(input)
    count = 0
    input.each_char do |char|
      case char
      when '('
        count += 1
      when ')'
        count -= 1
      else
        # ignore the character
      end
    end
    count
  end

  def self.part2(input)
    count = 0
    input.each_char.with_index do |char,i|
      case char
      when '('
        count += 1
      when ')'
        count -= 1
      else
        # ignore the character
      end
      if count < 0
        return i + 1
        break
      end
    end
    return
  end
end
