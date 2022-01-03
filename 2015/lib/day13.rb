# https://adventofcode.com/2015/day/13

class Day13

  def self.part1(input)
    graph =  read_input input
    people = graph.keys

    happinesses = calculate_happinesses people, graph
    happinesses.max
  end

  def self.part2(input)
    graph =  read_input input
    people = graph.keys
    people << "self"

    happinesses = calculate_happinesses people, graph
    happinesses.max
  end

  def self.calculate_happinesses(people, graph)
    people.permutation(people.size).map do |ordering|
      subject = ordering.last
      happiness = 0
      ordering.each do |target|
        happiness += graph[subject][target]
        subject = target
      end
      happiness
    end
  end

  def self.read_input(input)
    graph = Hash.new { |h,k| h[k] = Hash.new(0) }

    input.each do |line|
      /(?<subject>\w+) would (?<direction>gain|lose) (?<happy>\d+) happiness units by sitting next to (?<target>\w+)\./ =~ line
      case direction
      when "gain"
        graph[subject][target] += happy.to_i
        graph[target][subject] += happy.to_i
      when "lose"
        graph[subject][target] -= happy.to_i
        graph[target][subject] -= happy.to_i
      end
    end

    graph
  end
end
