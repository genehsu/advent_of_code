# https://adventofcode.com/2021/day/10

class Day10

  def self.score_corrupted(line)
    stack = []
    line.each_char do |c|
      case c
      when '(', '[', '{', '<'
        stack << c
      when ')'
        return 3 unless stack.pop == '('
      when ']'
        return 57 unless stack.pop == '['
      when '}'
        return 1197 unless stack.pop == '{'
      when '>'
        return 25137 unless stack.pop == '<'
      end
    end
    nil
  end

  def self.part1(input)
    input.map { |line| score_corrupted(line) }.compact.sum
  end

  SCORE_LOOKUP = {
    '(' => 1,
    '[' => 2,
    '{' => 3,
    '<' => 4,
  }

  def self.score_autocomplete(line)
    stack = []
    line.each_char do |c|
      case c
      when '(', '[', '{', '<'
        stack << c
      when ')'
        return unless stack.pop == '('
      when ']'
        return unless stack.pop == '['
      when '}'
        return unless stack.pop == '{'
      when '>'
        return unless stack.pop == '<'
      end
    end

    score = 0
    while (c = stack.pop)
      score *= 5
      score += SCORE_LOOKUP[c]
    end
    score
  end

  def self.part2(input)
    scores = input.map { |line| score_autocomplete(line) }.compact.sort
    scores[scores.size/2]
  end
end
