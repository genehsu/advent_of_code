# frozen_string_literal: true
# https://adventofcode.com/2021/day/14

class Day14

  def initialize(substrate, rules)
    @original = substrate
    @substrate = pairwise substrate
    @rules = expand_rules rules
  end

  def pairwise(substrate)
    index = Hash.new(0)
    substrate.size.times do |i|
      pair = substrate[i,2]
      break if pair.size < 2
      index[pair] += 1
    end
    index
  end

  def expand_rules(rules)
    rules.each do |pair, element|
      rules[pair] = [
        "#{pair[0]}#{element}",
        "#{element}#{pair[1]}"
      ]
    end
  end

  def polymerize
    polymer = Hash.new(0)
    @substrate.each do |pair, count|
      @rules[pair].each do |replacement|
        polymer[replacement] += count
      end
    end
    @substrate = polymer
  end

  def score
    frequencies = Hash.new(0)
    @substrate.each do |pair, count|
      frequencies[pair[0]] += count
      frequencies[pair[1]] += count
    end
    frequencies[@original[0]] += 1
    frequencies[@original[-1]] += 1
    frequencies.each do |char, count|
      frequencies[char] = count/2
    end
    frequencies.values.max - frequencies.values.min
  end

  def self.read(input)
    substrate = input.shift
    input.shift
    rules = {}
    input.each do |line|
      /^(?<pair>\w\w) -> (?<element>\w)/ =~ line
      rules[pair] = element
    end
    new(substrate, rules)
  end

  def self.part1(input)
    polymer = read(input)
    10.times { polymer.polymerize }
    polymer.score
  end

  def self.part2(input)
    polymer = read(input)
    40.times { polymer.polymerize }
    polymer.score
  end
end
