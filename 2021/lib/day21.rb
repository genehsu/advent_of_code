# https://adventofcode.com/2021/day/21
# --- Day 21: Dirac Dice ---

class Day21
  # There's not much to do as you slowly descend to the bottom of the ocean.
  # The submarine computer challenges you to a nice game of Dirac Dice.
  #
  # This game consists of a single die, two pawns, and a game board with a
  # circular track containing ten spaces marked 1 through 10 clockwise. Each
  # player's starting space is chosen randomly (your puzzle input). Player 1
  # goes first.
  #
  # Players take turns moving. On each player's turn, the player rolls the die
  # three times and adds up the results. Then, the player moves their pawn that
  # many times forward around the track (that is, moving clockwise on spaces in
  # order of increasing value, wrapping back around to 1 after 10). So, if a
  # player is on space 7 and they roll 2, 2, and 1, they would move forward 5
  # times, to spaces 8, 9, 10, 1, and finally stopping on 2.
  #
  # After each player moves, they increase their score by the value of the
  # space their pawn stopped on. Players' scores start at 0. So, if the first
  # player starts on space 7 and rolls a total of 5, they would stop on space 2
  # and add 2 to their score (for a total score of 2). The game immediately
  # ends as a win for any player whose score reaches at least 1000.
  #
  # Since the first game is a practice game, the submarine opens a compartment
  # labeled deterministic dice and a 100-sided die falls out. This die always
  # rolls 1 first, then 2, then 3, and so on up to 100, after which it starts
  # over at 1 again. Play using this die.
  #
  # For example, given these starting positions:
  #
  # Player 1 starting position: 4
  # Player 2 starting position: 8
  #
  # This is how the game would go:
  #
  #     Player 1 rolls 1+2+3 and moves to space 10 for a total score of 10.
  #     Player 2 rolls 4+5+6 and moves to space 3 for a total score of 3.
  #     Player 1 rolls 7+8+9 and moves to space 4 for a total score of 14.
  #     Player 2 rolls 10+11+12 and moves to space 6 for a total score of 9.
  #     Player 1 rolls 13+14+15 and moves to space 6 for a total score of 20.
  #     Player 2 rolls 16+17+18 and moves to space 7 for a total score of 16.
  #     Player 1 rolls 19+20+21 and moves to space 6 for a total score of 26.
  #     Player 2 rolls 22+23+24 and moves to space 6 for a total score of 22.
  #
  # ...after many turns...
  #
  #     Player 2 rolls 82+83+84 and moves to space 6 for a total score of 742.
  #     Player 1 rolls 85+86+87 and moves to space 4 for a total score of 990.
  #     Player 2 rolls 88+89+90 and moves to space 3 for a total score of 745.
  #     Player 1 rolls 91+92+93 and moves to space 10 for a final score, 1000.
  #
  # Since player 1 has at least 1000 points, player 1 wins and the game ends.
  # At this point, the losing player had 745 points and the die had been rolled
  # a total of 993 times; 745 * 993 = 739785.
  #
  # Play a practice game using the deterministic 100-sided die. The moment
  # either player wins, what do you get if you multiply the score of the losing
  # player by the number of times the die was rolled during the game?

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

  # Now that you're warmed up, it's time to play the real game.
  #
  # A second compartment opens, this time labeled Dirac dice. Out of it falls a
  # single three-sided die.
  #
  # As you experiment with the die, you feel a little strange. An informational
  # brochure in the compartment explains that this is a quantum die: when you
  # roll it, the universe splits into multiple copies, one copy for each
  # possible outcome of the die. In this case, rolling the die always splits
  # the universe into three copies: one where the outcome of the roll was 1,
  # one where it was 2, and one where it was 3.
  #
  # The game is played the same as before, although to prevent things from
  # getting too far out of hand, the game now ends when either player's score
  # reaches at least 21.
  #
  # Using the same starting positions as in the example above, player 1 wins in
  # 444356092776315 universes, while player 2 merely wins in 341960390180808
  # universes.
  #
  # Using your given starting positions, determine every possible outcome. Find
  # the player that wins in more universes; in how many universes does that
  # player win?

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
