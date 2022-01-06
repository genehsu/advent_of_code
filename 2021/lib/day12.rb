# frozen_string_literal: true
#
# https://adventofcode.com/2021/day/12

class Day12

  class Graph
    def initialize
      @data = Hash.new { |h,k| h[k] = [] }
      @small = {}
    end

    def add(from, to)
      @data[from] << to unless to == 'start' || from == 'end'
      @data[to] << from unless from == 'start' || to == 'end'
      @small[from] = from == from.downcase
      @small[to] = to == to.downcase
    end

    def path_count(node, visited={})
      return 0 if visited[node]
      return 1 if node == 'end'
      v = visited.dup
      v[node] = true if node == node.downcase
      @data[node].map { |node| path_count(node, v) }.sum
    end

    def path_count2(node, visited={}, small_double=false)
      return 0 if small_double && visited[node]
      return 1 if node == 'end'
      v = visited.dup
      if @small[node]
        small_double ||= v[node]
        v[node] = true
      end
      @data[node].map { |child| path_count2(child, v, small_double) }.sum
    end

    def self.parse(input)
      Graph.new.tap do |graph|
        input.each do |line|
          graph.add *line.split('-')
        end
      end
    end
  end

  def self.part1(input)
    graph = Graph.parse input
    graph.path_count('start')
  end

  def self.part2(input)
    graph = Graph.parse input
    graph.path_count2('start')
  end
end
