# https://adventofcode.com/2015/day/3

class Day03

  def self.part1(input)
    grid = Hash.new {|h,k| h[k] = {} }
    count = 1
    x = y = 0
    grid[x][y] = true

    input.each_char.with_index do |char,i|
      case char
      when '<'
        x -= 1
      when '>'
        x += 1
      when '^'
        y -= 1
      when 'v'
        y += 1
      else
        # ignore the character
      end
      count += 1 unless grid[x][y]
      grid[x][y] = true
    end

    count
  end

  def self.part2(input)
    grid = Hash.new {|h,k| h[k] = {} }
    count = 1
    x = y = 0
    rx = ry = 0
    grid[x][y] = true

    input.each_char.with_index do |char,i|
      case char
      when '<'
        x -= 1
      when '>'
        x += 1
      when '^'
        y -= 1
      when 'v'
        y += 1
      else
        # ignore the character
      end
      count += 1 unless grid[x][y]
      grid[x][y] = true
      rx, ry, x, y = x, y, rx, ry
    end

    count
  end
end
