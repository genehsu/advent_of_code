# frozen_string_literal: true
# https://adventofcode.com/2021/day/24

class Day24

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
