# https://adventofcode.com/2021/day/3

class Day03

  MORE_COMMON = -> (count) { count["0"] > count["1"] ? "0" : "1" }
  LESS_COMMON = -> (count) { count["0"] > count["1"] ? "1" : "0" }

  class Report1
    def initialize(input)
      number_size = input[0].size
      @counts = []
      number_size.times do |i|
        @counts << input.map { |n| n[i] }.tally
      end
    end

    def count(fxn)
      @counts
        .map { |count| fxn.call(count) }
        .join("").to_i(2)
    end

    def epsilon
      count MORE_COMMON
    end

    def gamma
      count LESS_COMMON
    end
  end

  def self.part1(input)
    report = Report1.new input
    return [report.gamma, report.epsilon]
  end

  class Report2
    def initialize(input)
      @input = input
    end

    def count_filter(fxn)
      numbers = @input
      numbers.first.size.times do |i|
        count = numbers.map { |n| n[i] }.tally
        target = fxn.call(count)
        numbers = numbers.select { |n| n[i] == target }
        break if numbers.size == 1
      end
      numbers.first.to_i(2)
    end

    def oxygen
      count_filter MORE_COMMON
    end

    def co2
      count_filter LESS_COMMON
    end
  end

  def self.part2(input)
    report = Report2.new input
    return [report.oxygen, report.co2]
  end
end
