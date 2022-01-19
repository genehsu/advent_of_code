# https://adventofcode.com/2016/day/7

class Day07
  ABBA_RE = /([a-z])(?!\1)([a-z])\2\1/

  def self.support_tls?(line)
    segments = line.split(/\[|\]/)
    positives = segments.values_at(*(0..segments.size-1).step(2).to_a)
    negatives = segments.values_at(*(1..segments.size-1).step(2).to_a)
    positives.find { |s| s =~ ABBA_RE } &&
      !negatives.find { |s| s =~ ABBA_RE }
  end

  def self.part1(input)
    input.count { |line| support_tls? line }
  end

  def self.aba_parts(segment)
    parts = []
    (segment.size-2).times do |i|
      next unless segment[i] == segment[i+2]
      next unless segment[i] != segment[i+1]
      parts << [segment[i], segment[i+1]]
    end
    parts
  end

  def self.contains_bab?(parts, negatives)
    string = negatives.join(' ')
    parts.find { |a,b| string.include? [b,a,b].join('') }
  end

  def self.support_ssl?(line)
    segments = line.split(/\[|\]/)
    positives = segments.values_at(*(0..segments.size-1).step(2).to_a)
    negatives = segments.values_at(*(1..segments.size-1).step(2).to_a)
    parts = positives.map { |s| aba_parts s }.reduce(&:+)
    contains_bab? parts, negatives
  end

  def self.part2(input)
    input.count { |line| support_ssl? line }
  end
end
