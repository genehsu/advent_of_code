# https://adventofcode.com/2015/day/17

class Day17

  def self.paths(total, index, buckets, path=[])
    return [path] if total == 0
    return [] if buckets.size == index

    paths(total, index+1, buckets, path) +
      paths(total-buckets[index], index+1, buckets, path+[buckets[index]])
  end

  def self.part1(input, quantity)
    buckets = input.map { |line| line.to_i }
    paths(quantity, 0, buckets).count
  end

  def self.part2(input, quantity)
    buckets = input.map { |line| line.to_i }
    solutions = paths(quantity, 0, buckets)
    shortest_path = solutions.min_by(&:size)
    solutions.select { |path| path.size == shortest_path.size }.size
  end
end
