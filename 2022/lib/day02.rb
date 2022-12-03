# https://adventofcode.com/2022/day/2

class Day02
  SCORE_MAP1 = {
    'A X' => 4, # Rock Rock
    'A Y' => 8, # Rock Paper
    'A Z' => 3, # Rock Scissors
    'B X' => 1, # Paper Rock
    'B Y' => 5, # Paper Paper
    'B Z' => 9, # Paper Scissors
    'C X' => 7, # Scissors Rock
    'C Y' => 2, # Scissors Paper
    'C Z' => 6, # Scissors Scissors
  }.freeze

  def self.part1(input)
    input.map { |line| SCORE_MAP1[line] }.sum
  end

  SCORE_MAP2 = {
    'A X' => 3, # Rock Lose (Scissors)
    'A Y' => 4, # Rock Draw (Rock)
    'A Z' => 8, # Rock Win (Paper)
    'B X' => 1, # Paper Lose (Rock)
    'B Y' => 5, # Paper Draw (Paper)
    'B Z' => 9, # Paper Win (Scissors)
    'C X' => 2, # Scissors Lose (Paper)
    'C Y' => 6, # Scissors Draw (Scissors)
    'C Z' => 7, # Scissors Win (Rock)
  }.freeze

  def self.part2(input)
    input.map { |line| SCORE_MAP2[line] }.sum
  end
end
