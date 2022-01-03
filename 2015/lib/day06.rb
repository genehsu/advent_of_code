# https://adventofcode.com/2015/day/6

require_relative '../../lib/util'

class Day06

  def self.part1(input)
    field = Array.new(1000, 0)

    input.each do |line|
      /^(?<command>toggle|turn on|turn off) (?<x1>\d+),(?<y1>\d+) through (?<x2>\d+),(?<y2>\d+)/ =~ line
      x1, y1, x2, y2 = [x1, y1, x2, y2].map(&:to_i)

      case command
      when 'toggle'
        dx = x2 - x1
        fx = (1 << (dx+1)) - 1
        fx <<= x1
        (y1..y2).each do |y|
          field[y] ^= fx
        end
      when 'turn on'
        dx = x2 - x1
        fx = (1 << (dx+1)) - 1
        fx <<= x1
        (y1..y2).each do |y|
          field[y] |= fx
        end
      when 'turn off'
        mask = (1 << 1000) - 1
        dx = x2 - x1
        fx = (1 << (dx+1)) - 1
        fx <<= x1
        fx ^= mask
        (y1..y2).each do |y|
          field[y] &= fx
        end
      end
    end

    field.map { |row| Util.count_bits row }.sum
  end

  def self.part2(input)
    field = Array.new(1000) { Array.new(1000, 0) }

    input.each do |line|
      /^(?<command>toggle|turn on|turn off) (?<x1>\d+),(?<y1>\d+) through (?<x2>\d+),(?<y2>\d+)/ =~ line
      x1, y1, x2, y2 = [x1, y1, x2, y2].map(&:to_i)

      case command
      when 'toggle'
        (x1..x2).each do |x|
          (y1..y2).each do |y|
            field[x][y] += 2
          end
        end
      when 'turn on'
        (x1..x2).each do |x|
          (y1..y2).each do |y|
            field[x][y] += 1
          end
        end
      when 'turn off'
        (x1..x2).each do |x|
          (y1..y2).each do |y|
            field[x][y] -= 1 if field[x][y] > 0
          end
        end
      end
    end

    field.map(&:sum).sum
  end
end
