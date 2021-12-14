# https://adventofcode.com/2015/day/23
# --- Day 23: Opening the Turing Lock ---

class Day23
  # Little Jane Marie just got her very first computer for Christmas from some
  # unknown benefactor. It comes with instructions and an example program, but
  # the computer itself seems to be malfunctioning. She's curious what the
  # program does, and would like you to help her run it.
  #
  # The manual explains that the computer supports two registers and six
  # instructions (truly, it goes on to remind the reader, a state-of-the-art
  # technology). The registers are named a and b, can hold any non-negative
  # integer, and begin with a value of 0. The instructions are as follows:
  #
  #     hlf r sets register r to half its current value, then continues with the next instruction.
  #
  #     tpl r sets register r to triple its current value, then continues with the next instruction.
  #
  #     inc r increments register r, adding 1 to it, then continues with the next instruction.
  #
  #     jmp offset is a jump; it continues with the instruction offset away relative to itself.
  #
  #     jie r, offset is like jmp, but only jumps if register r is even ("jump if even").
  #
  #     jio r, offset is like jmp, but only jumps if register r is 1 ("jump if one", not odd).
  #
  # All three jump instructions work with an offset relative to that
  # instruction. The offset is always written with a prefix + or - to indicate
  # the direction of the jump (forward or backward, respectively). For example,
  # jmp +1 would simply continue with the next instruction, while jmp +0 would
  # continuously jump back to itself forever.
  #
  # The program exits when it tries to run an instruction beyond the ones
  # defined.
  #
  # For example, this program sets a to 2, because the jio instruction causes
  # it to skip the tpl instruction:
  #
  # inc a
  # jio a, +2
  # tpl a
  # inc a
  #
  # What is the value in register b when the program in your puzzle input is
  # finished executing?

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

  # The unknown benefactor is very thankful for releasi-- er, helping little
  # Jane Marie with her computer. Definitely not to distract you, what is the
  # value in register b after the program is finished executing if register a
  # starts as 1 instead?

  def self.part2(input, register)
    machine = new input
    machine.a = 1
    machine.run
    machine.register register
  end
end
