# https://adventofcode.com/2015/day/9
# --- Day 9: All in a Single Night ---

class Day09
  # Every year, Santa manages to deliver all of his presents in a single night.
  #
  # This year, however, he has some new locations to visit; his elves have
  # provided him the distances between every pair of locations. He can start
  # and end at any two (different) locations he wants, but he must visit each
  # location exactly once. What is the shortest distance he can travel to
  # achieve this?
  #
  # For example, given the following distances:
  #
  # London to Dublin = 464
  # London to Belfast = 518
  # Dublin to Belfast = 141
  #
  # The possible routes are therefore:
  #
  # Dublin -> London -> Belfast = 982
  # London -> Dublin -> Belfast = 605
  # London -> Belfast -> Dublin = 659
  # Dublin -> Belfast -> London = 659
  # Belfast -> Dublin -> London = 605
  # Belfast -> London -> Dublin = 982
  #
  # The shortest of these is London -> Dublin -> Belfast = 605, and so the
  # answer is 605 in this example.
  #
  # What is the distance of the shortest route?

  def self.read_graph(input)
    graph = Hash.new {|h,k| h[k] = {} }

    input.each do |line|
      /^(?<source>\w+) to (?<destination>\w+) = (?<distance>\d+)/ =~ line
      distance = distance.to_i
      graph[source][destination] = distance
      graph[destination][source] = distance
    end

    graph
  end

  def self.path_distance(locations, graph)
    distance = 0
    source = nil
    locations.each do |destination|
      if source
        distance += graph[source][destination]
      end
      source = destination
    end
    distance
  end

  def self.part1(input)
    graph = read_graph(input)
    locations = graph.keys
    distances = locations
      .permutation(locations.size)
      .map { |path| path_distance(path, graph) }
    distances.min
  end

  # The next year, just to show off, Santa decides to take the route with the
  # longest distance instead.
  #
  # He can still start and end at any two (different) locations he wants, and
  # he still must visit each location exactly once.
  #
  # For example, given the distances above, the longest route would be 982 via
  # (for example) Dublin -> London -> Belfast.
  #
  # What is the distance of the longest route?

  def self.part2(input)
    graph = read_graph(input)
    locations = graph.keys
    distances = locations
      .permutation(locations.size)
      .map { |path| path_distance(path, graph) }
    distances.max
  end
end
