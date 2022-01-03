# https://adventofcode.com/2015/day/23

class Day23

  def initialize(input)
    @program = parse input
    @registers = { "a" => 0, "b" => 0 }
    @line = 0
  end

  def run
    while @line < @program.size
      # p [@line, @program[@line], @registers]
      step
    end
  end

  def a=(value)
    @registers["a"] = value
  end

  def register(register)
    @registers[register]
  end

  def step
    instruction = @program[@line]
    case instruction.first
    when "hlf"
      @registers[instruction[1]] /= 2
      @line += 1
    when "tpl"
      @registers[instruction[1]] *= 3
      @line += 1
    when "inc"
      @registers[instruction[1]] += 1
      @line += 1
    when "jmp"
      @line += instruction[1].to_i
    when "jie"
      if @registers[instruction[1]].even?
        @line += instruction[2].to_i
      else
        @line += 1
      end
    when "jio"
      if @registers[instruction[1]] == 1
        @line += instruction[2].to_i
      else
        @line += 1
      end
    end
  end

  def parse(input)
    input.map { |line| line.split(/[ ,]+/) }
  end

  def self.part1(input, register)
    machine = new input
    machine.run
    machine.register register
  end

  def self.part2(input, register)
    machine = new input
    machine.a = 1
    machine.run
    machine.register register
  end
end
