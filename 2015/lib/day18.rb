# https://adventofcode.com/2015/day/18

class Day18

  def self.read_grid(input)
    grid = []
    grid = input.map { |line| ".#{line}." }
    grid.push "." * grid.first.size
    grid.unshift "." * grid.first.size
  end

  NEIGHBOR_LOOKUP = {
    "###" => 3,
    "##." => 2,
    "#.#" => 2,
    ".##" => 2,
    "#.." => 1,
    ".#." => 1,
    "..#" => 1,
    "..." => 0,
  }

  NEIGHBOR_CENTER_LOOKUP = {
    "###" => 2,
    "##." => 1,
    "#.#" => 2,
    ".##" => 1,
    "#.." => 1,
    ".#." => 0,
    "..#" => 1,
    "..." => 0,
  }

  # This lookup version seems to be more than 2x faster than counting all 8
  # neighbors individually
  def self.neighbors_lookup(grid, x, y)
    NEIGHBOR_LOOKUP[grid[y-1][(x-1)..(x+1)]] +
      NEIGHBOR_CENTER_LOOKUP[grid[y][(x-1)..(x+1)]] +
      NEIGHBOR_LOOKUP[grid[y+1][(x-1)..(x+1)]]
  end

  def self.neighbors(grid, x, y)
    [[-1, -1], [-1, 0], [-1, 1],
     [ 0, -1],          [ 0, 1],
     [ 1, -1], [ 1, 0], [ 1, 1],
    ].count do |dx, dy|
      grid[y+dy][x+dx] == '#'
    end
  end

  def self.step(grid)
    new_grid = []
    grid.size.times { new_grid << "." * grid.size }
    (1..grid.size-2).each do |y|
      temp = new_grid[y]
      (1..grid[y].size-2).each do |x|
        n = neighbors_lookup(grid, x, y)
        if n == 3 || n == 2 && grid[y][x] == '#'
          temp[x] = '#'
        end
      end
    end
    new_grid
  end

  def self.count(grid)
    grid.map do |line|
      line.each_char.count { |c| c == '#' }
    end.sum
  end

  def self.part1(input, steps)
    grid = read_grid input
    steps.times { grid = step grid }
    count(grid)
  end

  def self.part2(input, steps)
    grid = read_grid input
    set_corners grid
    steps.times { grid = step grid; set_corners grid }
    count(grid)
  end

  def self.set_corners(grid)
    z = grid.size - 2
    grid[1][1] = '#'
    grid[1][z] = '#'
    grid[z][1] = '#'
    grid[z][z] = '#'
  end
end
