# https://adventofcode.com/2015/day/4

require 'digest'

class Day04

  def self.part1(input)
    mine(input, 5)
  end

  def self.part2(input)
    mine(input, 6)
  end

  def self.mine(prefix, zeroes)
    md5 = Digest::MD5.new
    i = 0
    z00s = '0' * zeroes
    while true
      md5.reset
      md5 << prefix
      md5 << i.to_s
      break if md5.hexdigest[0, zeroes] == z00s
      i += 1
    end
    i
  end
end
