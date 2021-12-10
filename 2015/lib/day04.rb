# https://adventofcode.com/2015/day/4
# --- Day 4: The Ideal Stocking Stuffer ---

require 'digest'

class Day04
  # Santa needs help mining some AdventCoins (very similar to bitcoins) to use
  # as gifts for all the economically forward-thinking little girls and boys.
  #
  # To do this, he needs to find MD5 hashes which, in hexadecimal, start with
  # at least five zeroes. The input to the MD5 hash is some secret key (your
  # puzzle input, given below) followed by a number in decimal. To mine
  # AdventCoins, you must find Santa the lowest positive number (no leading
  # zeroes: 1, 2, 3, ...) that produces such a hash.
  #
  # For example:
  #
  #     If your secret key is abcdef, the answer is 609043, because the MD5
  #     hash of abcdef609043 starts with five zeroes (000001dbbfa...), and it
  #     is the lowest such number to do so.
  #     If your secret key is pqrstuv, the lowest number it combines with to
  #     make an MD5 hash starting with five zeroes is 1048970; that is, the MD5
  #     hash of pqrstuv1048970 looks like 000006136ef....

  def self.part1(input)
    mine(input, 5)
  end

  # Now find one that starts with six zeroes.

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
