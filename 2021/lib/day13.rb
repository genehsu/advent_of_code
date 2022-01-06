# https://adventofcode.com/2021/day/13

require_relative '../../lib/util'

class Day13

  def self.parse(input)
    @graph = []
    @folds = nil
    input.each do |line|
      if line == ""
        @folds = []
        next
      end
      if @folds
        /^fold along (?<axis>[xy])=(?<value>\d+)/ =~ line
        @folds << [axis.to_sym, value.to_i]
      else
        /^(?<x>\d+),(?<y>\d+)/ =~ line
        row = @graph[y.to_i] || 0
        row |= 1 << x.to_i
        @graph[y.to_i] = row
      end
    end
    @graph = @graph.map { |row| row || 0 }
  end

  def self.dump
    size = @graph.map(&:bit_length).max
    @graph.each do |row|
      size.times do |x|
        print row[x] == 1 ? '*' : ' '
      end
      puts
    end
    puts
  end

  def self.fold(axis, value)
    case axis
    when :x
      fold_x(value)
    when :y
      fold_y(value)
    end
  end

  def self.fold_x(value)
    mask = (1 << value + 1) - 1
    @graph = @graph.map do |row|
      before = row & mask
      after = row >> value + 1
      after = after.digits(2)
      while after.size < value
        after << 0
      end
      after = after.join('').to_i(2)
      before | after
    end
  end

  def self.fold_y(value)
    before = @graph[0, value]
    after = @graph[value+1..-1]
    while before.size < after.size
      before << 0
    end
    while after.size < before.size
      after << 0
    end
    after = after.reverse
    @graph = before.zip(after).map { |b,a| a | b }
  end

  def self.count_dots
    @graph.map { |row| Util.count_bits(row) }.sum
  end

  def self.part1(input)
    parse input
    fold *@folds.first
    count_dots
  end

  def self.part2(input)
    parse input
    @folds.each do |axis, value|
      fold axis, value
    end
    dump
    count_dots
  end
end
