# https://adventofcode.com/2022/day/12

class Day12
  class Solver
    attr_reader :grid

    X, Y = [0, 1]

    def initialize(grid)
      @grid = grid
      @start = find_start
      @end = find_end
      @x_size = @grid[0].size
      @y_size = @grid.size
      @grid[@start[Y]][@start[X]] = 'a'
      @grid[@end[Y]][@end[X]] = 'z'
      @values = Array.new(@y_size) { Array.new(@x_size) }
      @all_starts = []
      find_all_starts
    end

    def find_all_starts
      grid.size.times do |y|
        grid[0].size.times do |x|
          if grid[y][x] == 'a'
            @all_starts << [x,y]
          end
        end
      end
    end

    def find_char(char)
      x = y = 0
      grid.size.times do |i|
        y = i
        x = grid[i].index(char)
        break if x
      end
      [x, y]
    end

    def explore
      @nodes = [@end]
      set_value_at(@end, 0)

      while @nodes.size > 0
        explore_one
      end
    end

    def explore_one
      current = @nodes.shift
      current_value = value_at(current)
      current_height = height_at(current)
      x,y = current
      [[x-1,y], [x+1,y], [x,y-1], [x,y+1]].each do |test|
        if value_at(test).nil? && current_height - height_at(test) <= 1
          @nodes << test
          set_value_at(test, current_value+1)
        end
      end

      @nodes.sort_by! { |node| value_at(node) } # TODO, shift to PriorityQueue
    end

    def height_at(coord)
      x,y = coord
      @grid[y][x].ord
    end

    def value_at(coord)
      x,y = coord
      (0...@y_size).cover?(y) &&
        (0...@x_size).cover?(x) &&
        @values[y][x]
    end

    def set_value_at(coord, value)
      x,y = coord
      @values[y][x] = value
    end

    def start_solution
      value_at(@start)
    end

    def best_solution
      @all_starts.map { |coord| value_at(coord) || 999_999_999 }.min
    end

    def find_start
      find_char('S')
    end

    def find_end
      find_char('E')
    end
  end

  def self.part1(input)
    solver = Solver.new(input)
    solver.explore
    solver.start_solution
  end

  def self.part2(input)
    solver = Solver.new(input)
    solver.explore
    solver.best_solution
  end
end
