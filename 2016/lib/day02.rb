# https://adventofcode.com/2016/day/2

class Day02
  def self.parse(coord, line, keypad)
    y, x = coord
    line.each_char do |c|
      case c
      when "U"
        y -= 1 if keypad[y-1][x]
      when "L"
        x -= 1 if keypad[y][x-1]
      when "R"
        x += 1 if keypad[y][x+1]
      when "D"
        y += 1 if keypad[y+1][x]
      end
    end
    coord[0] = y
    coord[1] = x
    keypad[y][x]
  end

  PART1 = [
    [nil, nil, nil, nil, nil],
    [nil, "1", "2", "3", nil],
    [nil, "4", "5", "6", nil],
    [nil, "7", "8", "9", nil],
    [nil, nil, nil, nil, nil],
  ]

  def self.part1(input)
    coord = [2, 2]
    input.map { |line| parse coord, line, PART1 }.join('')
  end

  PART2 = [
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, "1", nil, nil, nil],
    [nil, nil, "2", "3", "4", nil, nil],
    [nil, "5", "6", "7", "8", "9", nil],
    [nil, nil, "A", "B", "C", nil, nil],
    [nil, nil, nil, "D", nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
  ]

  def self.part2(input)
    coord = [3, 1]
    input.map { |line| parse coord, line, PART2 }.join('')
  end
end
