# https://adventofcode.com/2021/day/18

require 'json'

class Day18

  attr_reader :data

  LEFT = 0
  RIGHT = 1

  def initialize(data)
    @data = parse data
  end

  def parse(data)
    String === data ? JSON.parse(data) : data
  end

  def add(other)
    @data = [@data, parse(other)]
    reduce
  end

  def reduce
    reduce if explode || split
  end

  def explore
    stack = []
    stack << [RIGHT] << [LEFT]
    while path = stack.pop
      element = dig *path

      return true if yield path, element

      next if Numeric === element
      next if path.size == 4
      stack << path + [RIGHT]
      stack << path + [LEFT]
    end
  end

  def explode
    explore do |path, element|
      if ! (Numeric === element) && path.size == 4
        explode_to LEFT, path, element[LEFT]
        explode_to RIGHT, path, element[RIGHT]
        parent = dig *path[0, path.size-1]
        parent[path[-1]] = 0
      end
    end
  end

  def split
    explore do |path, element|
      if Numeric === element && element >= 10
        left = element / 2
        right = element - left
        parent = dig *path[0, path.size-1]
        parent[path[-1]] = [left, right]
      end
    end
  end

  def explode_to(side, path, value)
    temp = path.dup
    while i = temp.pop
      next if i == side
      element = dig *temp

      i = side
      while element && !(Numeric === element[i])
        element = element[i]
        i = 1-side
      end

      element[i] += value if element
      break
    end
  end

  def dig(*params)
    if params.empty?
      data
    else
      data.dig *params
    end
  end

  def magnitude
    eval_pair(data)
  end

  def eval_pair(pair)
    return pair if Numeric === pair
    eval_pair(pair[LEFT]) * 3 +
      eval_pair(pair[RIGHT]) * 2
  end

  def self.part1(input)
    fish = new input.shift
    input.each { |other| fish.add other }
    fish.magnitude
  end

  def self.part2(input)
    pairs = (0...input.size).to_a.permutation(2).map do |a,b|
      fish = new "[#{input[a]},#{input[b]}]"
      fish.reduce
      fish.magnitude
    end.max
  end
end
