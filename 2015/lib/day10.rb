# https://adventofcode.com/2015/day/10

class Day10

  def self.part1(input)
    40.times { input = look_and_say input }
    input.length
  end

  def self.part2(input)
    50.times { input = look_and_say input }
    input.length
  end

  def self.look_and_say(input)
    digit = nil
    output = []
    count = 0
    input.length.times do |i|
      if !digit
        count = 1
        digit = input[i]
      elsif input[i] == digit
        count += 1
      else
        output << count.to_s
        output << digit
        digit = input[i]
        count = 1
      end
    end
    output << count.to_s
    output << digit
    output.join('')
  end
end
