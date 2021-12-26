# https://adventofcode.com/2021/day/24
# --- Day 24: Arithmetic Logic Unit ---
# frozen_string_literal: true

class Day24
  # Magic smoke starts leaking from the submarine's arithmetic logic unit
  # (ALU). Without the ability to perform basic arithmetic and logic
  # functions, the submarine can't produce cool patterns with its Christmas
  # lights!
  #
  # It also can't navigate. Or run the oxygen system.
  #
  # Don't worry, though - you probably have enough oxygen left to give you
  # enough time to build a new ALU.
  #
  # The ALU is a four-dimensional processing unit: it has integer variables
  # w, x, y, and z. These variables all start with the value 0. The ALU also
  # supports six instructions:
  #
  #     inp a - Read an input value and write it to variable a.
  #
  #     add a b - Add the value of a to the value of b, then store the
  #     result in variable a.
  #
  #     mul a b - Multiply the value of a by the value of b, then store the
  #     result in variable a.
  #
  #     div a b - Divide the value of a by the value of b, truncate the
  #     result to an integer, then store the result in variable a. (Here,
  #     "truncate" means to round the value toward zero.)
  #
  #     mod a b - Divide the value of a by the value of b, then store the
  #     remainder in variable a. (This is also called the modulo operation.)
  #
  #     eql a b - If the value of a and b are equal, then store the value 1
  #     in variable a. Otherwise, store the value 0 in variable a.
  #
  # In all of these instructions, a and b are placeholders; a will always be
  # the variable where the result of the operation is stored (one of w, x,
  # y, or z), while b can be either a variable or a number. Numbers can be
  # positive or negative, but will always be integers.
  #
  # The ALU has no jump instructions; in an ALU program, every instruction
  # is run exactly once in order from top to bottom. The program halts after
  # the last instruction has finished executing.
  #
  # (Program authors should be especially cautious; attempting to execute
  # div with b=0 or attempting to execute mod with a<0 or b<=0 will cause
  # the program to crash and might even damage the ALU. These operations are
  # never intended in any serious ALU program.)
  #
  # For example, here is an ALU program which takes an input number, negates
  # it, and stores it in x:
  #
  # inp x
  # mul x -1
  #
  # Here is an ALU program which takes two input numbers, then sets z to 1
  # if the second input number is three times larger than the first input
  # number, or sets z to 0 otherwise:
  #
  # inp z
  # inp x
  # mul z 3
  # eql z x
  #
  # Here is an ALU program which takes a non-negative integer as input,
  # converts it into binary, and stores the lowest (1's) bit in z, the
  # second-lowest (2's) bit in y, the third-lowest (4's) bit in x, and the
  # fourth-lowest (8's) bit in w:
  #
  # inp w
  # add z w
  # mod z 2
  # div w 2
  # add y w
  # mod y 2
  # div w 2
  # add x w
  # mod x 2
  # div w 2
  # mod w 2
  #
  # Once you have built a replacement ALU, you can install it in the
  # submarine, which will immediately resume what it was doing when the ALU
  # failed: validating the submarine's model number. To do this, the ALU
  # will run the MOdel Number Automatic Detector program (MONAD, your puzzle
  # input).
  #
  # Submarine model numbers are always fourteen-digit numbers consisting
  # only of digits 1 through 9. The digit 0 cannot appear in a model number.
  #
  # When MONAD checks a hypothetical fourteen-digit model number, it uses
  # fourteen separate inp instructions, each expecting a single digit of the
  # model number in order of most to least significant. (So, to check the
  # model number 13579246899999, you would give 1 to the first inp
  # instruction, 3 to the second inp instruction, 5 to the third inp
  # instruction, and so on.) This means that when operating MONAD, each
  # input instruction should only ever be given an integer value of at least
  # 1 and at most 9.
  #
  # Then, after MONAD has finished running all of its instructions, it will
  # indicate that the model number was valid by leaving a 0 in variable z.
  # However, if the model number was invalid, it will leave some other
  # non-zero value in z.
  #
  # MONAD imposes additional, mysterious restrictions on model numbers, and
  # legend says the last copy of the MONAD documentation was eaten by a
  # tanuki. You'll need to figure out what MONAD does some other way.
  #
  # To enable as many submarine features as possible, find the largest valid
  # fourteen-digit model number that contains no 0 digits. What is the
  # largest model number accepted by MONAD?

  class ALU
    def initialize(input)
      @register = {
        x: 0,
        y: 0,
        z: 0,
        w: 0,
      }
      @program = []
      input.each do |line|
        instruction = line.split(/ /)
        instruction[0] = instruction[0].to_sym
        instruction[1] = instruction[1].to_sym
        if ('0'..'9').include?(line[-1])
          instruction[-1] = instruction[-1].to_i
        else
          instruction[-1] = instruction[-1].to_sym
        end
        @program << instruction
      end
      @stack = []
    end

    def x
      @register[:x]
    end

    def y
      @register[:y]
    end

    def z
      @register[:z]
    end

    def w
      @register[:w]
    end

    def clear
      @register[:x] = 0
      @register[:y] = 0
      @register[:z] = 0
      @register[:w] = 0
    end

    def add(a, b)
      @register[a] += b
    end

    def mul(a, b)
      @register[a] *= b
    end

    def div(a, b)
      @register[a] /= b
    end

    def mod(a, b)
      @register[a] %= b
    end

    def eql(a, b)
      @register[a] = (@register[a] == b) ? 1 : 0
    end

    def nex(a, _)
      @register[:x] = (w == (z % 26 + a)) ? 0 : 1
    end

    def nez(a, b)
      @register[:z] = z / a * (25 * x + 1) + x * (w + b)
    end

    def push(a, b)
      @stack << @register[a] + b
    end

    def pop(a, b)
      z = (@stack.pop + b <=> @register[a])
    end

    CMD = {
      :add => ->(a,b) { "#{a} += #{b}" },
      :mul => ->(a,b) { "#{a} *= #{b}" },
      :div => ->(a,b) { "#{a} /= #{b}" },
      :mod => ->(a,b) { "#{a} %= #{b}" },
      :eql => ->(a,b) { "#{a} = (#{a} == #{b})" },
      :nex => ->(a,_) { "x = (w != (z % 26 + #{a}))" },
      :nez => ->(a,b) { "z = (z/#{a}) * (25*x + 1) + x*(w + #{b})" },
      :push => ->(a,b) { "stack.push #{a} + #{b}" },
      :pop => ->(a,b) { "z = (stack.pop + #{b} <=> #{a})" }
    }
    def run(argument, length=nil)
      argument = argument.to_s
      length ||= argument.size
      pointer = 0
      @program.each do |cmd, arg1, arg2|
        if CMD[cmd]
          b = arg2.is_a?(Integer) ? arg2 : @register[arg2]
          send(cmd, arg1, b)
        elsif cmd == :inp
          break if length == pointer
          raise "Not enough digits to input" if pointer == argument.size
          raise "Illegal 0 in input" if argument[pointer] == '0'

          @register[arg1] = argument[pointer].to_i
          pointer += 1
        end
      end
    end

    def monadify
      raise "Not regular" if @program.size % 14 != 0
      new_program = []
      monad_size = @program.size / 14
      (0...@program.size).step(monad_size) do |i|
        cmds = @program[i,monad_size]
        new_program << cmds[0] # inp w
        new_program << [:nex, cmds[5][2]] # the next x value
        new_program << [:nez, cmds[4][2], cmds[15][2]] # the next z value
      end
      @program = new_program
    end

    def dump_relations_min_max
      stack = []
      pairings = []
      (0...@program.size).step(3) do |i|
        index = i/3
        cmds = @program[i,3]
        if cmds[2][1] == 1
          stack << [index, cmds[2][2]]
        else
          n, offset = stack.pop
          pairings << [index, n, offset + cmds[1][1]]
        end
      end
      min = []
      max = []
      pairings.each do |d1, d2, offset|
        sign = offset > 0 ? '+' : '-'
        puts "[#{d1}] = [#{d2}] #{sign} #{offset.abs}"
        if offset > 0
          min[d2] = 1
          min[d1] = 1 + offset
          max[d1] = 9
          max[d2] = 9 - offset
        else
          min[d1] = 1
          min[d2] = 1 - offset
          max[d2] = 9
          max[d1] = 9 + offset
        end
      end
      puts "part1 = #{ max.join('') }"
      puts "part2 = #{ min.join('') }"
      [min.join(''), max.join('')]
    end

    def dump
      pointer = 0
      @program.each do |cmd, a, b|
        if CMD[cmd]
          puts CMD[cmd].call(a, b)
        elsif cmd == :inp
          puts "#{a} = [#{pointer}]"
          pointer += 1
        end
      end
    end
  end

  def self.run(code)
    alu = ALU.new code
    alu.monadify
    min, max = alu.dump_relations_min_max
    alu.clear
    alu.run min
    min_z = alu.z
    alu.clear
    alu.run max
    max_z = alu.z
    (min_z == 0) && (max_z == 0)
  end
end
