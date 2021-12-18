# https://adventofcode.com/2016/day/1
# --- Day 1: No Time for a Taxicab ---

class Day01
  # Santa's sleigh uses a very high-precision clock to guide its movements, and
  # the clock's oscillator is regulated by stars. Unfortunately, the stars have
  # been stolen... by the Easter Bunny. To save Christmas, Santa needs you to
  # retrieve all fifty stars by December 25th.
  #
  # Collect stars by solving puzzles. Two puzzles will be made available on
  # each day in the Advent calendar; the second puzzle is unlocked when you
  # complete the first. Each puzzle grants one star. Good luck!
  #
  # You're airdropped near Easter Bunny Headquarters in a city somewhere.
  # "Near", unfortunately, is as close as you can get - the instructions on the
  # Easter Bunny Recruiting Document the Elves intercepted start here, and
  # nobody had time to work them out further.
  #
  # The Document indicates that you should start at the given coordinates
  # (where you just landed) and face North. Then, follow the provided sequence:
  # either turn left (L) or right (R) 90 degrees, then walk forward the given
  # number of blocks, ending at a new intersection.
  #
  # There's no time to follow such ridiculous instructions on foot, though, so
  # you take a moment and work out the destination. Given that you can only
  # walk on the street grid of the city, how far is the shortest path to the
  # destination?
  #
  # For example:
  #
  #     Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks away.
  #     R2, R2, R2 leaves you 2 blocks due South of your starting position, which is 2 blocks away.
  #     R5, L5, R5, R3 leaves you 12 blocks away.
  #
  # How many blocks away is Easter Bunny HQ?

  attr_reader :x, :y, :twice

  def initialize(directions)
    @directions = directions
    @current = :N
    @x = 0
    @y = 0
    @grid = Hash.new(0)
    @twice = nil
    travel
  end

  def travel
    @directions.each do |turn, amount|
      make_turn turn
      move amount
    end
  end

  def make_turn(turn)
    case @current
    when :N
      @current = turn == "L" ? :W : :E
    when :S
      @current = turn == "L" ? :E : :W
    when :E
      @current = turn == "L" ? :N : :S
    when :W
      @current = turn == "L" ? :S : :N
    end
  end

  def move(amount)
    case @current
    when :N
      (@y+1).upto(@y+amount).each do |y|
        mark_grid @x, y
      end
      @y += amount
    when :S
      (@y-1).downto(@y-amount).each do |y|
        mark_grid @x, y
      end
      @y -= amount
    when :E
      (@x+1).upto(@x+amount).each do |x|
        mark_grid x, @y
      end
      @x += amount
    when :W
      (@x-1).downto(@x-amount).each do |x|
        mark_grid x, @y
      end
      @x -= amount
    end
  end

  def mark_grid(x, y)
    coord = [x, y]
    @grid[coord] += 1
    @twice ||= coord if @grid[coord] == 2
  end

  def self.parse(input)
    directions = input.split(/, /).map { |l| turn, n = l.split(//, 2); [turn, n.to_i] }
    new directions
  end

  def self.part1(input)
    travel = parse input
    travel.x.abs + travel.y.abs
  end

  # Then, you notice the instructions continue on the back of the Recruiting
  # Document. Easter Bunny HQ is actually at the first location you visit
  # twice.
  #
  # For example, if your instructions are R8, R4, R4, R8, the first location
  # you visit twice is 4 blocks away, due East.
  #
  # How many blocks away is the first location you visit twice?

  def self.part2(input)
    travel = parse input
    travel.twice.map(&:abs).sum
  end
end
