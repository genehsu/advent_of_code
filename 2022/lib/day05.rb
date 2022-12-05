# https://adventofcode.com/2022/day/5

class Day05
  def self.parse_grid(grid, line)
    grid_index = 0
    1.step(by: 4, to: line.length) do |i|
      grid[grid_index] ||= []
      char = line[i]
      grid[grid_index] << char if char != ' '
      grid_index += 1
    end
  end

  def self.mover1(grid, count, source, destination)
    grid[destination-1].unshift *grid[source-1].slice!(0,count).reverse
  end

  def self.mover2(grid, count, source, destination)
    grid[destination-1].unshift *grid[source-1].slice!(0,count)
  end

  def self.parse_move(grid, line, mover)
    /move (?<count>\d+) from (?<source>\d+) to (?<destination>\d+)/ =~ line
    count, source, destination = [count, source, destination].map(&:to_i)
    mover.call(grid, count, source, destination)
  end

  def self.parse(grid, input, mover)
    input.each do |line|
      case line
      when /\[/
        parse_grid(grid, line)
      when /move/
        parse_move(grid, line, mover)
      else
        # ignore
      end
    end
  end

  def self.part1(input)
    grid = []
    parse(grid, input, method(:mover1))
    grid.map(&:first).join
  end

  def self.part2(input)
    grid = []
    parse(grid, input, method(:mover2))
    grid.map(&:first).join
  end
end
