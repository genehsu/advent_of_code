# https://adventofcode.com/2015/day/19

class Day19

  def self.parse_replacements(replace_inputs)
    subs = Hash.new { |h,k| h[k] = [] }
    replace_inputs.map do |line|
      /^(?<target>\w+) => (?<replacement>\w+)$/ =~ line
      subs[target] << replacement
    end
    subs
  end

  def self.part1(input, replace_inputs)
    subs = parse_replacements replace_inputs
    molecules = {}

    subs.each do |target, replacements|
      offset = 0
      while pos = input.index(target, offset)
        replacements.each do |replacement|
          copy = input.dup
          copy[pos, target.size] = replacement
          molecules[copy] = true
        end
        offset = pos + 1
      end
    end
    molecules.size
  end

  def self.parse_inverse_replacements(replace_inputs)
    replace_inputs.map do |line|
      /^(?<target>\w+) => (?<replacement>\w+)$/ =~ line
      [replacement, target]
    end.to_h
  end

  def self.part2(input, replace_inputs)
    subs = parse_inverse_replacements replace_inputs
    replacements = subs.keys
      .sort_by { |x| -x.length }
      .map { |s| Regexp.new(s) }
    depth = 0
    substrate = input

    while substrate != 'e'
      replacements.each do |replacement|
        next unless replacement =~ substrate
        target = subs[replacement.source]
        substrate = substrate.sub(replacement, target)
        depth += 1
        break
      end
    end
    depth
  end
end
