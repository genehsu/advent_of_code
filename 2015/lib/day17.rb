# https://adventofcode.com/2015/day/17
# --- Day 17: No Such Thing as Too Much ---

class Day17
  # The elves bought too much eggnog again - 150 liters this time. To fit it
  # all into your refrigerator, you'll need to move it into smaller containers.
  # You take an inventory of the capacities of the available containers.
  #
  # For example, suppose you have containers of size 20, 15, 10, 5, and 5
  # liters. If you need to store 25 liters, there are four ways to do it:
  #
  #     15 and 10
  #     20 and 5 (the first 5)
  #     20 and 5 (the second 5)
  #     15, 5, and 5
  #
  # Filling all containers entirely, how many different combinations of
  # containers can exactly fit all 150 liters of eggnog?

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

  # While playing with all the containers in the kitchen, another load of
  # eggnog arrives! The shipping and receiving department is requesting as many
  # containers as you can spare.
  #
  # Find the minimum number of containers that can exactly fit all 150 liters
  # of eggnog. How many different ways can you fill that number of containers
  # and still hold exactly 150 litres?
  #
  # In the example above, the minimum number of containers was two. There were
  # three ways to use that many containers, and so the answer there would be 3.

  def self.part2(input, quantity)
    buckets = input.map { |line| line.to_i }
    solutions = paths(quantity, 0, buckets)
    shortest_path = solutions.min_by(&:size)
    solutions.select { |path| path.size == shortest_path.size }.size
  end
end
