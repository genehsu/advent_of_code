# https://adventofcode.com/2021/day/21

class Day21

  class Player
    attr_reader :position, :score

    def initialize(position, die)
      @position = position
      @score = 0
      @die = die
    end

    def move
      @position += roll + roll + roll
      @position %= 10
      @score += @position
      @score += 10 if @position == 0
    end

    def roll
      @die.roll
    end
  end

  class Die
    def initialize
      @roll = 0
    end

    def roll
      @roll += 1
      @roll % 100
    end

    def count
      @roll
    end
  end

  def self.part1(input)
    die = Die.new
    player = Player.new input[1], die
    other = Player.new input[0], die
    while player.score < 1000
      player, other = other, player
      player.move
    end
    other.score * die.count
  end

  require 'matrix'

  def self.generate_node(node, sum_of_rolls)
    position, score = node[node[0]]
    position += sum_of_rolls
    position -= 10 if position > 10
    score += position
    node.dup.tap do |new_node|
      new_node[node[0]] = [position, score]
      new_node[0] = 3 - node[0]
    end
  end

  def self.win(node, wins)
    if wins[node]
      wins[node]
    elsif node[1][1] >= 21
      Vector[1, 0]
    elsif node[2][1] >= 21
      Vector[0, 1]
    end
  end

  def self.part2a(input)
    wins = {}
    stack = []
    starting_node = [1, [input[0], 0], [input[1], 0]]
    stack << starting_node
    while node = stack.pop
      children = (3..9).map { |i| generate_node(node, i) }
      if children.all? { |c| win c, wins }
        # If the number of wins have been calculated for all the children
        # we can calculate the wins for this node
        wins[node] =
          win(children[0], wins) * 1 +
          win(children[1], wins) * 3 +
          win(children[2], wins) * 6 +
          win(children[3], wins) * 7 +
          win(children[4], wins) * 6 +
          win(children[5], wins) * 3 +
          win(children[6], wins) * 1
      else
        stack << node
        children.each { |c| stack << c unless win(c, wins) }
      end
    end
    wins[starting_node].to_a.max
  end

  DIRAC_DICE = [1, 2, 3].repeated_permutation(3).map(&:sum).tally.freeze

  def self.dirac(p1, s1, p2, s2, cache = {})
    key = [p1, s1, p2, s2]
    return cache[key] if cache.key? key

    cache[key] = DIRAC_DICE.map do |move, frequency|
      pos = (p1 + move) % 10
      score = s1 + pos + 1
      if score >= 21
        [frequency, 0]
      else
        result = dirac(p2, s2, pos, score, cache)
        [result[1] * frequency, result[0] * frequency]
      end
    end.each_with_object([0, 0]) do |node, obj|
      obj[0] += node[0]
      obj[1] += node[1]
    end
  end

  def self.part2(input)
    dirac(input[0]-1, 0, input[1]-1, 0).to_a.max
  end
end
