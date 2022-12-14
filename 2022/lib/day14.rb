# https://adventofcode.com/2022/day/14

class Day14
  class Game
    attr_reader :grains

    def initialize
      @cells = Hash.new(' ')
      @x_range = [500,500]
      @y_range = [0,0]
      @grains = 0
    end

    def add_wall(x,y)
      @x_range[0] = [@x_range[0], x].min
      @x_range[1] = [@x_range[1], x].max
      @y_range[1] = [@y_range[1], y].max
      @max_y = @y_range[1]
      @cells[[x,y]] = '#'
    end

    def drop_sand
      while drop_optimized
        # puts self
      end
    end

    def drop_one
      x, y = 500, 0
      return false unless @cells[[x,y]] == ' '

      while y < @max_y
        y += 1
        if @cells[[x,y]] == ' '
        elsif @cells[[x-1,y]] == ' '
          x -= 1
        elsif @cells[[x+1,y]] == ' '
          x += 1
        else
          @cells[[x,y-1]] = 'O'
          @grains += 1
          return true
        end
      end
      false
    end

    def drop_optimized
      x, y = 500, 0
      return false unless @cells[[x,y]] == ' '

      while y < @max_y
        n = 1
        if @cells[[x,y+n]] == ' '
        elsif @cells[[x-n,y+n]] == ' '
          while y < @max_y
            n += 1
            break if @cells[[x-n+1,y+n]] == ' '
            break if @cells[[x-n,y+n]] != ' '
            break if @cells[[x-n+2,y+n]] == ' '
          end
          if @cells[[x-n,y+n]] != ' ' &&
              @cells[[x-n+1,y+n]] != ' ' &&
              @cells[[x-n+2,y+n]] != ' '
            (1..n-1).each { |i| @cells[[x-i,y+i]] = '/' }
            @grains += n-1
            return true
          end
          n -= 1
          x -= n

        elsif @cells[[x+n,y+n]] == ' '
          while y < @max_y
            n += 1
            break if @cells[[x+n-1,y+n]] == ' '
            break if @cells[[x+n,y+n]] != ' '
            break if @cells[[x+n-2,y+n]] == ' '
          end
          if @cells[[x+n,y+n]] != ' ' &&
              @cells[[x+n-1,y+n]] != ' ' &&
              @cells[[x+n-2,y+n]] != ' '
            (1..n-1).each { |i| @cells[[x+i,y+i]] = '/' }
            @grains += n-1
            return true
          end
          n -= 1
          x += n

        else
          @cells[[x,y]] = 'O'
          @grains += 1
          return true
        end
        y += n
      end
      false
    end

    def create_floor
      max_y = @y_range[1] + 2
      (500-max_y..500+max_y).each do |x|
        add_wall(x, max_y)
      end
    end

    def to_s
      Range.new(*@y_range)
        .map do |y|
          Range.new(*@x_range)
            .map { |x| @cells[[x,y]] }
            .join('')
        end.join("\n")
    end

    def self.parse(input)
      game = Game.new
      input.each do |line|
        cx = cy = nil
        line.split(/ -> /).each do |coords|
          /\A(?<x>\d+),(?<y>\d+)\z/ =~ coords
          x = x.to_i
          y = y.to_i

          if cx == x
            cy.step(to: y, by: y <=> cy) do |ny|
              game.add_wall(x,ny)
            end
          end
          if cy == y
            cx.step(to: x, by: x <=> cx) do |nx|
              game.add_wall(nx,y)
            end
          end
          cx, cy = x, y
        end
      end
      game
    end
  end

  def self.part1(input)
    game = Game.parse(input)
    game.drop_sand
    puts game
    game.grains
  end

  def self.part2(input)
    game = Game.parse(input)
    game.create_floor
    game.drop_sand
    puts game
    game.grains
  end
end
