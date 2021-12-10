# https://adventofcode.com/2015/day/1
# --- Day 6: Probably a Fire Hazard ---

class Day06

  # Because your neighbors keep defeating you in the holiday house decorating
  # contest year after year, you've decided to deploy one million lights in a
  # 1000x1000 grid.
  #
  # Furthermore, because you've been especially nice this year, Santa has
  # mailed you instructions on how to display the ideal lighting configuration.
  #
  # Lights in your grid are numbered from 0 to 999 in each direction; the
  # lights at each corner are at 0,0, 0,999, 999,999, and 999,0. The
  # instructions include whether to turn on, turn off, or toggle various
  # inclusive ranges given as coordinate pairs. Each coordinate pair represents
  # opposite corners of a rectangle, inclusive; a coordinate pair like 0,0
  # through 2,2 therefore refers to 9 lights in a 3x3 square. The lights all
  # start turned off.
  #
  # To defeat your neighbors this year, all you have to do is set up your
  # lights by doing the instructions Santa sent you in order.
  #
  # For example:
  #
  #     turn on 0,0 through 999,999 would turn on (or leave on) every light.
  #     toggle 0,0 through 999,0 would toggle the first line of 1000 lights,
  #     turning off the ones that were on, and turning on the ones that were
  #     off.
  #     turn off 499,499 through 500,500 would turn off (or leave off) the
  #     middle four lights.
  #
  # After following the instructions, how many lights are lit?

  def self.part1(input)
    field = Array.new(1000) { Array.new(1000, 0) }

    input.each do |line|
      /^(?<command>toggle|turn on|turn off) (?<x1>\d+),(?<y1>\d+) through (?<x2>\d+),(?<y2>\d+)/ =~ line
      x1, y1, x2, y2 = [x1, y1, x2, y2].map(&:to_i)

      case command
      when 'toggle'
        (x1..x2).each do |x|
          (y1..y2).each do |y|
            field[x][y] ^= 1
          end
        end
      when 'turn on'
        (x1..x2).each do |x|
          (y1..y2).each do |y|
            field[x][y] = 1
          end
        end
      when 'turn off'
        (x1..x2).each do |x|
          (y1..y2).each do |y|
            field[x][y] = 0
          end
        end
      end
    end

    field.map(&:sum).sum
  end

  # You just finish implementing your winning light pattern when you realize
  # you mistranslated Santa's message from Ancient Nordic Elvish.
  #
  # The light grid you bought actually has individual brightness controls; each
  # light can have a brightness of zero or more. The lights all start at zero.
  #
  # The phrase turn on actually means that you should increase the brightness
  # of those lights by 1.
  #
  # The phrase turn off actually means that you should decrease the brightness
  # of those lights by 1, to a minimum of zero.
  #
  # The phrase toggle actually means that you should increase the brightness of
  # those lights by 2.
  #
  # What is the total brightness of all lights combined after following Santa's
  # instructions?
  #
  # For example:
  #
  #     turn on 0,0 through 0,0 would increase the total brightness by 1.
  #     toggle 0,0 through 999,999 would increase the total brightness by
  #     2000000.

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

  BIT_LOOKUP = [
    0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
    4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8
  ]

  def self.count_bits(n)
    init_lookup
    count = 0
    while n > 0
      count += BIT_LOOKUP[n & 0xff]
      n >> 8
    end
    count
  end
end
