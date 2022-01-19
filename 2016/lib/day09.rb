# https://adventofcode.com/2016/day/9

class Day09
  def self.length(parsed)
    parsed[1, parsed.size].map do |part|
      if part.is_a? Numeric
        part
      else
        length(part)
      end
    end.sum * parsed[0]
  end

  def self.parse1(input)
    parsed = [1]
    partial = 0
    state = :char
    i = 0
    while i < input.size
      case state
      when :char
        # default
        if input[i] == '('
          parsed << i-partial
          mlength = 0
          mmult = 0
          state = :mlength
        end
      when :mlength
        if ('0'..'9').include? input[i]
          mlength *= 10
          mlength += input[i].to_i
        elsif input[i] == 'x'
          state = :mmult
        end
      when :mmult
        if  ('0'..'9').include? input[i]
          mmult *= 10
          mmult += input[i].to_i
        elsif input[i] == ')'
          parsed << [mmult, mlength]
          i += mlength
          state = :char
          partial = i+1
        end
      end
      i += 1
    end
    parsed << input.size - partial
  end

  def self.part1(input)
    length parse1 input
  end

  def self.parse2(input, start = 0, multiplier = 1, index_bounds = nil)
    parsed = [multiplier]
    partial = start
    state = :char
    index_bounds ||= input.size
    i = start
    while i < index_bounds
      char = input[i]
      case state
      when :char
        # default
        if char == '('
          parsed << i-partial
          mlength = 0
          mmult = 0
          state = :mlength
        end
      when :mlength
        if ('0'..'9').include? char
          mlength *= 10
          mlength += char.to_i
        elsif char == 'x'
          state = :mmult
        end
      when :mmult
        if  ('0'..'9').include? char
          mmult *= 10
          mmult += char.to_i
        elsif char == ')'
          mstart= i+1
          parsed << parse2(input, mstart, mmult, mlength+mstart)
          i += mlength
          state = :char
          partial = i+1
        end
      end
      i += 1
    end
    parsed << index_bounds - partial
  end

  def self.part2(input)
    length parse2 input
  end
end
