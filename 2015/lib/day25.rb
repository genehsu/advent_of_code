# https://adventofcode.com/2015/day/25

class Day25

  MODULUS = 33_554_393
  INITIAL_VALUE = 20151125

  def self.part1(row, column)
    sum = row + column
    ordinal = sum * (sum+1) / 2 - sum - row + 1
    bits = [252533]
    n = 0
    while (1<<n) < ordinal
      bits[n+1] = bits[n] * bits[n] % MODULUS
      n += 1
    end

    m = ordinal - 1
    n = 0
    code = INITIAL_VALUE
    while m > 0
      if m & 1 == 1
        code *= bits[n]
        code %= MODULUS
      end
      n += 1
      m >>= 1
    end
    code
  end
end
