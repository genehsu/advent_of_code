# https://adventofcode.com/2015/day/7

class Day07

  MASK = (1 << 16) - 1

  Wire = {}
  Signal = {}

  def self.parse(input)
    input.each do |line|
      /^(?:(?<input2>\w+) (?<binary>AND|OR|LSHIFT|RSHIFT) |(?<unary>NOT) |)(?<input1>\w+) -> (?<target>[a-z]+)/ =~ line
      # p [target, unary || binary, input1, input2, line]
      Wire[target] = [unary || binary, input1, input2]
    end
  end

  def self.value_of(label)
    return label.to_i if label.to_i.to_s == label
    return Signal[label] if Signal[label]
    command, input1, input2 = Wire[label]

    # p [label, command, input1, input2]
    case command
    when nil
      Signal[label] = value_of(input1)
    when 'NOT'
      Signal[label] = value_of(input1) ^ MASK
    when 'AND'
      Signal[label] = value_of(input1) & value_of(input2)
    when 'OR'
      Signal[label] = value_of(input1) | value_of(input2)
    when 'LSHIFT'
      Signal[label] = (value_of(input2) << value_of(input1)) & MASK
    when 'RSHIFT'
      Signal[label] = value_of(input2) >> value_of(input1)
    end
    # p ['->', label, '==', Signal[label]]
    Signal[label]
  end

  def self.part1(input, label)
    Wire.clear
    Signal.clear
    parse(input)
    value_of(label)
  end

  def self.part2(input, label)
    Wire.clear
    Signal.clear
    parse(input)
    Signal['b'] = 16076
    value_of(label)
  end
end
