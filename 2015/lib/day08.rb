# https://adventofcode.com/2015/day/8

class Day08

  def self.part1(input)
    total_size = 0
    content_size = 0

    input.each do |line|
      total_size += line.length
      line.gsub!(/\\x[a-f0-9]{2}/, '*')
      line.gsub!(/\\[\\"]/, '*')
      content_size +=  line.length - 2
    end

    total_size - content_size
  end

  def self.part2(input)
    total_size = 0
    encoded_size = 0

    input.each do |line|
      total_size += line.length
      line.gsub!(/[\\"]/, '**')
      encoded_size += line.length + 2
    end

    encoded_size - total_size
  end
end
