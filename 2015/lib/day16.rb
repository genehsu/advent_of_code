# https://adventofcode.com/2015/day/16

class Day16

  def self.parse(input)
    aunts = {}
    input.each do |line|
      /Sue (?<id>\d+): (?<rest>.*)/ =~ line
      aunts[id.to_i] = parse_aunt(rest)
    end
    aunts
  end

  def self.parse_aunt(rest)
    pairs = rest.split(/, ?/).map { |s| s.split(/: /) }
    pairs.map { |k,v| [k.to_sym, v.to_i] }.to_h
  end

  def self.matches?(aunt, trace)
    aunt.each do |k,v|
      return false unless trace[k].call(v)
    end
    true
  end

  def self.funky(trace)
    trace.map do |k,v|
      if v.is_a? Proc
        [k, v]
      else
        [k, ->(x) { x == v }]
      end
    end.to_h
  end

  def self.part1(input)
    aunts = parse input

    trace = {
      children: 3,
      cats: 7,
      samoyeds: 2,
      pomeranians: 3,
      akitas: 0,
      vizslas: 0,
      goldfish: 5,
      trees: 3,
      cars: 2,
      perfumes: 1,
    }
    trace = funky trace

    aunts.find do |id, aunt|
      matches? aunt, trace
    end.first
  end

  def self.part2(input)
    aunts = parse input

    trace = {
      children: 3,
      cats: ->(x) { x > 7 },
      samoyeds: 2,
      pomeranians: ->(x) { x < 3 },
      akitas: 0,
      vizslas: 0,
      goldfish: ->(x) { x < 5 },
      trees: ->(x) { x > 3 },
      cars: 2,
      perfumes: 1,
    }
    trace = funky trace

    aunts.find do |id, aunt|
      matches? aunt, trace
    end.first
  end
end
