# https://adventofcode.com/2021/day/8

class Day08

  def self.part1(input)
    count = 0
    input.each do |line|
      (_, number) = line.split(/ \| /)
      words = number.split(/ /)
      words.each do |word|
        case word.size
        when 2..4, 7
          count += 1
        end
      end
    end
    count
  end

  class SevenSegment
    def initialize(line)
      (digits, number) = line.split(/ \| /)
      @digits = digits.split(/ /).map { |w| w.chars.sort.join('') }
      @number = number.split(/ /).map { |w| w.chars.sort.join('') }
      @lookup = {}
      @inverse = Array.new(10)
      initialize_lookups
    end

    def number
      result = 0
      @number.each do |word|
        result *= 10
        result += @lookup[word]
      end
      result
    end

    def initialize_lookups
      @digits.each do |digit|
        case digit.size
        when 2
          @lookup[digit] = 1
          @inverse[1] = digit
        when 3
          @lookup[digit] = 7
          @inverse[7] = digit
        when 4
          @lookup[digit] = 4
          @inverse[4] = digit
        when 7
          @lookup[digit] = 8
          @inverse[8] = digit
        end
      end
      solve_235
      solve_069
    end

    def solve_235
      @digits.filter { |d| d.size == 5 }.each do |digit|
        if is_three?(digit)
          @lookup[digit] = 3
          @inverse[3] = digit
          next
        end

        if is_five?(digit)
          @lookup[digit] = 5
          @inverse[5] = digit
          next
        end

        @lookup[digit] = 2
        @inverse[2] = digit
      end
    end

    def solve_069
      @digits.filter { |d| d.size == 6 }.each do |digit|
        if is_nine?(digit)
          @lookup[digit] = 9
          @inverse[9] = digit
          next
        end

        if is_zero?(digit)
          @lookup[digit] = 0
          @inverse[0] = digit
          next
        end

        @lookup[digit] = 6
        @inverse[6] = digit
      end
    end

    def is_three?(digit)
      digit_contains(digit, @inverse[7].chars)
    end

    def is_five?(digit)
      digit_contains(digit, @inverse[4].chars - @inverse[1].chars)
    end

    def is_nine?(digit)
      digit_contains(digit, @inverse[1].chars) &&
        digit_contains(digit, @inverse[4].chars)
    end

    def is_zero?(digit)
      digit_contains(digit, @inverse[1].chars) &&
        !digit_contains(digit, @inverse[4].chars)
    end

    def digit_contains(digit, base)
      base.each { |c| return unless digit.include? c }
    end
  end

  def self.solve_digits_line(line)
    solver = SevenSegment.new(line)
    solver.number
  end

  def self.part2(input)
    input.sum do |line|
      solve_digits_line(line)
    end
  end
end
