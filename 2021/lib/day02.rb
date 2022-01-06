# https://adventofcode.com/2021/day/2

class Day02

  def self.part1(input)
    position = 0
    depth = 0
    input.each do |line|
      /(?<command>forward|down|up) (?<amount>\d+)/ =~ line
      case command.to_sym
      when :forward
        position += amount.to_i
      when :up
        depth -= amount.to_i
      when :down
        depth += amount.to_i
      end
    end
    [position, depth]
  end

  def self.part2(input)
    position = 0
    aim = 0
    depth = 0
    input.each do |line|
      /(?<command>forward|down|up) (?<amount>\d+)/ =~ line
      case command.to_sym
      when :forward
        position += amount.to_i
        depth += aim * amount.to_i
      when :up
        aim -= amount.to_i
      when :down
        aim += amount.to_i
      end
    end
    [position, depth]
  end
end
