# https://adventofcode.com/2015/day/9

class Day09

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

  def self.part2(input)
    graph = read_graph(input)
    locations = graph.keys
    distances = locations
      .permutation(locations.size)
      .map { |path| path_distance(path, graph) }
    distances.max
  end
end
