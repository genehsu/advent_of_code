# https://adventofcode.com/2022/day/9

class Day09
  class Game
    attr :nodes, :size

    def initialize(moves, size = 2)
      @moves = moves
      @visits = 0
      @size = size
      @nodes = Array.new(size) { Array.new(2, 0) }
      process_moves
    end

    def process_moves
      head = nodes.first
      tail = nodes.last
      v = Hash.new(0)

      @moves.each do |dir, count|
        hx, hy = choose_direction(dir)

        count.times do
          # move head
          head[0] += hx; head[1] += hy

          # adjust rest of rope
          (1...size).each do |i|
            current = nodes[i]
            previous = nodes[i-1]
            dx = previous[0] - current[0]
            dy = previous[1] - current[1]

            if dx.abs > 1 || dy.abs > 1
              current[0] += previous[0] <=> current[0]
              current[1] += previous[1] <=> current[1]
            end
          end

          v[tail.dup] += 1
        end
      end

      @visits = v.keys.size
    end

    def choose_direction(dir)
      case dir
      when 'L'
        [-1, 0]
      when 'R'
        [1, 0]
      when 'U'
        [0, 1]
      when 'D'
        [0, -1]
      end
    end

    def tail_visits
      @visits
    end
  end

  def self.parse_moves(input)
    input.map do |line|
      /\A(?<dir>.) (?<count>\d+)\z/ =~ line
      [dir, count.to_i]
    end
  end

  def self.part1(input)
    moves = parse_moves(input)
    game = Game.new(moves)
    game.tail_visits
  end

  def self.part2(input)
    moves = parse_moves(input)
    game = Game.new(moves, 10)
    game.tail_visits
  end
end
