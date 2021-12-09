def pilot_2a(input)
  position = 0
  depth = 0
  input.each do |line|
    /(?<command>forward|down|up) (?<amount>\d+)/ =~ line
    case command.to_sym
    when :forward
      position += amount.to_i
    when :up
      depth -= amount.to_i
    when :down
      depth += amount.to_i
    end
  end
  [position, depth]
end

def pilot_2b(input)
  position = 0
  aim = 0
  depth = 0
  input.each do |line|
    /(?<command>forward|down|up) (?<amount>\d+)/ =~ line
    case command.to_sym
    when :forward
      position += amount.to_i
      depth += aim * amount.to_i
    when :up
      aim -= amount.to_i
    when :down
      aim += amount.to_i
    end
  end
  [position, depth]
end

