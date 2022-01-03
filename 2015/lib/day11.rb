# https://adventofcode.com/2015/day/11

class Day11

  STRAIGHT = /abc|bcd|cde|def|efg|fgh|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz/
  def self.valid?(pass)
    return if /[iol]/ =~ pass
    return unless STRAIGHT =~ pass
    return unless /(\w)\1(?>.*(\w)\2)/ =~ pass
    true
  end

  def self.part1(input)
    pass = input.succ
    while !valid? pass
      pass = pass.succ
    end
    pass
  end
end
