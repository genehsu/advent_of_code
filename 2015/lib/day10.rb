# https://adventofcode.com/2015/day/10
# --- Day 10: Elves Look, Elves Say ---

class Day10
  # Today, the Elves are playing a game called look-and-say. They take turns
  # making sequences by reading aloud the previous sequence and using that
  # reading as the next sequence. For example, 211 is read as "one two, two
  # ones", which becomes 1221 (1 2, 2 1s).
  #
  # Look-and-say sequences are generated iteratively, using the previous value
  # as input for the next step. For each step, take the previous value, and
  # replace each run of digits (like 111) with the number of digits (3)
  # followed by the digit itself (1).
  #
  # For example:
  #
  #     1 becomes 11 (1 copy of digit 1).
  #     11 becomes 21 (2 copies of digit 1).
  #     21 becomes 1211 (one 2 followed by one 1).
  #     1211 becomes 111221 (one 1, one 2, and two 1s).
  #     111221 becomes 312211 (three 1s, two 2s, and one 1).
  #
  # Starting with the digits in your puzzle input, apply this process 40 times.
  # What is the length of the result?

  def self.part1(input)
    40.times { input = look_and_say input }
    input.length
  end

  # Neat, right? You might also enjoy hearing John Conway talking about this
  # sequence (that's Conway of Conway's Game of Life fame).
  #
  # Now, starting again with the digits in your puzzle input, apply this
  # process 50 times. What is the length of the new result?

  def self.part2(input)
    50.times { input = look_and_say input }
    input.length
  end

  def self.look_and_say(input)
    digit = nil
    output = []
    count = 0
    input.length.times do |i|
      if !digit
        count = 1
        digit = input[i]
      elsif input[i] == digit
        count += 1
      else
        output << count.to_s
        output << digit
        digit = input[i]
        count = 1
      end
    end
    output << count.to_s
    output << digit
    output.join('')
  end
end
