# https://adventofcode.com/2015/day/24

class Day24

  def initialize(input)
    @packages = input.sort.reverse
    @lookup = { 0 => { 0 => [[]] } }
  end

  def solve(buckets)
    target = @packages.sum / buckets

    1.upto(@packages.size).each do |n|
      @lookup[n] = {}
      @packages.each do |current|
        @lookup[n-1].each do |previous, paths|
          sum = current + previous
          next unless sum <= target
          paths.each do |path|
            next if path.include? current
            @lookup[n][sum] ||= []
            new_path = (path + [current]).sort

            next if @lookup[n][sum].include? new_path
            @lookup[n][sum] << new_path
          end
        end
      end
      optimize(n)
      break if @lookup[n][target]
    end

    n = @lookup.keys.max
    @lookup[n][target].map { |combo| combo.reduce(&:*) }.min
  end

  def optimize(n)
    # since we are looking for a certain criteria
    # we can prune all paths that don't fit the criteria
    @lookup[n].each do |sum, paths|
      min = paths.map { |combo| combo.reduce(&:*) }.min
      min_path = paths.select { |combo| combo.reduce(&:*) == min }
      @lookup[n][sum] = min_path
    end
  end

  def self.part1(input)
    sleigh = new input
    sleigh.solve(3)
  end

  def self.part2(input)
    sleigh = new input
    sleigh.solve(4)
  end
end
