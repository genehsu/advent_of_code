# https://adventofcode.com/2022/day/10

class Day10
  def self.parse(input)
    cycle = 1
    x = 1
    Array.new(241, 1).tap do |register|
      register[cycle] = x

      input.each do |line|
        /(?<cmd>\w+) ?(?<delta>-?\d+)?/ =~ line
        if cmd == 'noop'
          cycle += 1
          register[cycle] = x
        elsif cmd == 'addx'
          register[cycle+1] = x
          cycle += 2
          x += delta.to_i
          register[cycle] = x
        end
      end
    end
  end

  def self.part1(input)
    register = parse(input)
    20.step(by: 40, to: 220).map { |i| register[i] * i }.sum
  end

  def self.part2(input)
    register = parse(input)
    crt = Array.new(6) { ' ' * 40 }
    (1..240).each do |i|
      x = (i-1) % 40
      y = (i-1) / 40
      crt[y][x] = '█' if (x-1..x+1).include?(register[i])
    end
    crt.join("\n")
  end
end
