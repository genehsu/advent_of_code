# https://adventofcode.com/2015/day/7
# --- Day 7: Some Assembly Required ---

class Day07
  # This year, Santa brought little Bobby Tables a set of wires and bitwise
  # logic gates! Unfortunately, little Bobby is a little under the recommended
  # age range, and he needs help assembling the circuit.
  #
  # Each wire has an identifier (some lowercase letters) and can carry a 16-bit
  # signal (a number from 0 to 65535). A signal is provided to each wire by a
  # gate, another wire, or some specific value. Each wire can only get a signal
  # from one source, but can provide its signal to multiple destinations. A
  # gate provides no signal until all of its inputs have a signal.
  #
  # The included instructions booklet describes how to connect the parts
  # together: x AND y -> z means to connect wires x and y to an AND gate, and
  # then connect its output to wire z.
  #
  # For example:
  #
  #     123 -> x means that the signal 123 is provided to wire x.
  #     x AND y -> z means that the bitwise AND of wire x and wire y is
  #     provided to wire z.
  #     p LSHIFT 2 -> q means that the value from wire p is left-shifted by 2
  #     and then provided to wire q.
  #     NOT e -> f means that the bitwise complement of the value from wire e
  #     is provided to wire f.
  #
  # Other possible gates include OR (bitwise OR) and RSHIFT (right-shift). If,
  # for some reason, you'd like to emulate the circuit instead, almost all
  # programming languages (for example, C, JavaScript, or Python) provide
  # operators for these gates.
  #
  # For example, here is a simple circuit:
  #
  # 123 -> x
  # 456 -> y
  # x AND y -> d
  # x OR y -> e
  # x LSHIFT 2 -> f
  # y RSHIFT 2 -> g
  # NOT x -> h
  # NOT y -> i
  #
  # After it is run, these are the signals on the wires:
  #
  # d: 72
  # e: 507
  # f: 492
  # g: 114
  # h: 65412
  # i: 65079
  # x: 123
  # y: 456
  #
  # In little Bobby's kit's instructions booklet (provided as your puzzle
  # input), what signal is ultimately provided to wire a?

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

  # Now, take the signal you got on wire a, override wire b to that signal, and
  # reset the other wires (including wire a). What new signal is ultimately
  # provided to wire a?

  def self.part2(input, label)
    Wire.clear
    Signal.clear
    parse(input)
    Signal['b'] = 16076
    value_of(label)
  end
end
