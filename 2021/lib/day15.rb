# https://adventofcode.com/2021/day/15

require_relative '../../lib/priority_queue'

class Day15

  def self.parse(input)
    input.map { |row| row.split(//).map(&:to_i) }
  end

  def self.parse5(input)
    blocks = []
    5.times do |i|
      blocks << parse(input).map do |row|
        expand_row5 nth_row(i, row)
      end
    end
    blocks.reduce(&:+)
  end

  def self.nth_row(n, row)
    row.map do |i|
      m = n+i
      m > 9 ? m - 9 : m
    end
  end

  def self.expand_row5(row)
    expanded_row = []
    5.times do |i|
      expanded_row << nth_row(i, row)
    end
    expanded_row.reduce(&:+)
  end

  def self.simple_solve(grid)
    last_index = grid.size - 1
    # Don't count the starting position
    grid[0][0] = 0

    # Take care of last row/column special case
    y = last_index
    (last_index-1).downto(0) do |x|
      grid[last_index][x] += grid[last_index][x+1]
      grid[x][last_index] += grid[x+1][last_index]
    end

    # Now build up the rest of the table
    (last_index-1).downto(0) do |y|
      (last_index-1).downto(0) do |x|
        min_path = [grid[y][x+1], grid[y+1][x]].min
        grid[y][x] += min_path
      end
    end

    # The answer should be in the top left (0,0)
    grid[0][0]
  end

  def self.dijkstras(grid)
    # Don't count the starting position
    grid[0][0] = 0
    index_range = 0...grid.size
    target = [grid.size-1, grid.size-1]

    too_big = 999999
    distances = Array.new(grid.size) { Array.new(grid.size, too_big) }
    neighbors = PriorityQueue.new
    neighbors << [0,0,0]

    while node = neighbors.pop
      path, x, y = node

      # skip this node if the distance has already been set
      next unless distances[y][x] == too_big

      # set the distance of the current node
      current = path + grid[y][x]
      distances[y][x] = current
      return current if [x, y] == target

      # add the neighbors if they haven't been visited
      [[x+1, y],
       [x-1, y],
       [x, y+1],
       [x, y-1]
      ].each do |x1, y1|
        next unless index_range.include? x1
        next unless index_range.include? y1
        if distances[y1][x1] == too_big
          neighbors << [current, x1, y1]
        end
      end
    end
    distances[-1][-1]
  end

  def self.dump_grid(grid)
    grid.each do |row|
      puts row.join('')
    end
  end

  def self.dump_cells(grid)
    grid.each do |row|
      puts '%5d' * grid.size % row
    end
  end

  def self.part1(input)
    grid = parse input
    simple_solve grid
  end

  def self.part2(input)
    grid = parse5 input
    dijkstras grid
  end
end
