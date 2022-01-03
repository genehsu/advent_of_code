# https://adventofcode.com/2015/day/14

class Day14

  def self.read_line(line)
    /^(?<name>\w+) can fly (?<speed>\d+) km\/s for (?<duration>\d+) seconds, but then must rest for (?<rest>\d+) seconds\./ =~ line
    {
      name: name,
      speed: speed.to_i,
      duration: duration.to_i,
      rest: rest.to_i,
      points: 0,
    }
  end

  def self.distance_at(timepoint, data)
    cycles = timepoint / (data[:duration] + data[:rest])
    distance = data[:speed] * data[:duration] * cycles
    remainder = timepoint % (data[:duration] + data[:rest])
    if remainder > data[:duration]
      distance += data[:speed] * data[:duration]
    else
      distance += data[:speed] * remainder
    end
  end

  def self.part1(input, elapsed_time)
    input.map do |line|
      datum = read_line(line)
      distance_at(elapsed_time, datum).tap do |distance|
        puts "#{distance} -> #{datum[:name]}"
      end
    end.max
  end

  def self.part2(input, elapsed_time)
    data = []

    input.map do |line|
      data << read_line(line)
    end

    elapsed_time.times.each do |i|
      data.each { |datum| datum[:distance] = distance_at(i+1, datum) }
      max_distance = data.map { |datum| datum[:distance] }.max
      data
        .select { |datum| datum[:distance] == max_distance }
        .each { |datum| datum[:points] += 1 }
    end

    data.each do |datum|
      puts "#{datum[:points]} -> #{datum[:name]}"
    end

    data.map { |datum| datum[:points] }.max
  end
end
