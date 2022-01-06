# https://adventofcode.com/2021/day/19

class Day19

  require 'matrix'

  def self.generate_orientations
    orientations = []

    variants = [[1, 1, 1], [1, -1, -1], [-1, 1, -1], [-1, -1, 1]]

    base = [0, 1, 2]
    3.times do
      base = base.rotate
      variants.each do |a, b, c|
        m = Matrix.zero(3)
        m[0, base[0]] = a
        m[1, base[1]] = b
        m[2, base[2]] = c
        orientations << m
      end
    end

    base = [2, 1, 0]
    3.times do
      base = base.rotate
      variants.each do |a, b, c|
        m = Matrix.zero(3)
        m[0, base[0]] = -a
        m[1, base[1]] = -b
        m[2, base[2]] = -c
        orientations << m
      end
    end

    orientations
  end

  ORIENTATIONS = generate_orientations

  class Scanner
    attr_reader :id, :beacons, :magnitudes

    def initialize(id)
      @id = id
      @beacons = []
      @magnitudes = {}
      @lookup = {}
    end

    def <<(beacon)
      beacon = Vector[*beacon] unless beacon.is_a? Vector
      unless @lookup[beacon]
        @lookup[beacon] = true
        (0...@beacons.size).each do |i|
          delta = @beacons[i] - beacon
          magnitude = delta.dot(delta)
          magnitudes[magnitude] = [@beacons[i], beacon]
        end
        @beacons << beacon
      end
      self
    end

    def match(other)
      other.magnitudes.select { |amount, _| magnitudes[amount] }
    end

    def merge(other, matches)
      # figure out corresponding beacons
      beacon_lookup = Hash.new { |h,k| h[k] = Hash.new(0) }
      matches.each do |amount, other_beacons|
        beacons = magnitudes[amount]
        beacon_lookup[other_beacons[0]][beacons[0]] += 1
        beacon_lookup[other_beacons[1]][beacons[0]] += 1
        beacon_lookup[other_beacons[0]][beacons[1]] += 1
        beacon_lookup[other_beacons[1]][beacons[1]] += 1
      end
      beacon_lookup.keys.each do |key|
        target = beacon_lookup[key].find { |k,v| v != 1 }
        beacon_lookup[key] = target.first
      end

      # figure out rotation + translation
      translation = nil
      rotation = nil
      ORIENTATIONS.each do |m|
        target, main = beacon_lookup.first
        translation = main - (m * target)
        count = beacon_lookup.count do |target, main|
          main - (m * target) == translation
        end
        if count == beacon_lookup.size
          rotation = m
          break
        end
      end

      # finally add beacons to the main scanner
      other.beacons.each do |beacon|
        self << (rotation * beacon) + translation
      end

      [translation, rotation]
    end
  end

  class Overlapper
    def initialize(input)
      @scanners = []
      current = nil
      input.each do |line|
        if line.empty?
          current = nil
        elsif current
          current << line.split(/,/).map(&:to_i)
        else
          /^--- scanner (?<id>\d+) ---/ =~ line
          current = Scanner.new(id.to_i)
          @scanners << current
        end
      end
      @positions = [Vector[0,0,0]]
    end

    def merge
      graph = determine_merge_order
      @main = @scanners[0]
      visited = { 0 => true }
      stack = graph[0].map { |i, matches| [0, i, matches] }
      while (source, dest, matches = stack.pop)
        next if visited[dest]
        visited[dest] = true
        stack += graph[dest].map { |i, matches| [dest, i, matches] }
        source = @scanners[source]
        dest = @scanners[dest]
        translation, rotation = @main.merge dest, matches
        @positions << translation
      end
    end

    def determine_merge_order
      # When there are 12 corresponding nodes,
      # then there should be 66 magnitudes that correspond exactly
      graph = Hash.new { |h,k| h[k] = [] }
      (0...@scanners.size).each do |i|
        source = @scanners[i]
        (i...@scanners.size).each do |j|
          dest = @scanners[j]
          matches = source.match(dest)
          if matches.size == 66
            graph[i] << [j, matches]
            inverse_matches = dest.match(source)
            graph[j] << [i, inverse_matches]
          end
        end
      end
      graph
    end

    def max_manhattan_distance
      max = 0
      (0...@positions.size).each do |i|
        (i...@positions.size).each do |j|
          distance = (@positions[i] - @positions[j]).to_a.map(&:abs).sum
          max = [max, distance].max
        end
      end
      max
    end

    def beacons
      @main.beacons.size
    end
  end

  def self.part1(input)
    overlapper = Overlapper.new input
    overlapper.merge
    overlapper.beacons
  end

  def self.part2(input)
    overlapper = Overlapper.new input
    overlapper.merge
    overlapper.max_manhattan_distance
  end
end
