# https://adventofcode.com/2021/day/16

class Day16

  CHARS = {
    "0" => '0000',
    "1" => '0001',
    "2" => '0010',
    "3" => '0011',
    "4" => '0100',
    "5" => '0101',
    "6" => '0110',
    "7" => '0111',
    "8" => '1000',
    "9" => '1001',
    "A" => '1010',
    "B" => '1011',
    "C" => '1100',
    "D" => '1101',
    "E" => '1110',
    "F" => '1111',
  }

  class Packet
    attr_reader :version, :type, :values, :operation, :bits, :i

    def initialize(bits, start=0)
      @bits = bits
      @version = nil
      @type = nil
      @values = []
      @i = start
      parse
    end

    def parse
      return if bits.size - i < 7

      @version = parse_bits(3)
      @type = parse_bits(3)
      if type == 4
        parse_packet_data
      else
        add_subpackets
      end
    end

    def parse_bits(length)
      bits[i,length].to_i(2).tap { @i += length }
    end

    def parse_packet_data
      temp = ''
      continue = true
      while continue
        continue = parse_bits(1) == 1
        temp += bits[i,4]
        @i += 4
      end
      values << temp.to_i(2)
    end

    def add_subpackets
      if parse_bits(1) == 0
        bitlength = parse_bits(15)
        threshold = i + bitlength
        while i != threshold
          raise "Parse error" if i > threshold
          subpacket = Packet.new(bits, i)
          @i = subpacket.i
          values << subpacket
        end
      else
        packet_count = parse_bits(11)
        packet_count.times do
          subpacket = Packet.new(bits, i)
          @i = subpacket.i
          values << subpacket
        end
      end
    end

    def eval
      case type
      when 0
        @values.map(&:eval).sum
      when 1
        @values.map(&:eval).reduce(&:*)
      when 2
        @values.map(&:eval).min
      when 3
        @values.map(&:eval).max
      when 4
        @values.first
      when 5
        @values[0].eval > @values[1].eval ? 1 : 0
      when 6
        @values[0].eval < @values[1].eval ? 1 : 0
      when 7
        @values[0].eval == @values[1].eval ? 1 : 0
      end
    end

    def part1
      values.map { |value| value.is_a?(Packet) ? value.part1 : 0 }
        .sum + version
    end
  end

  def self.to_bits(input)
    input.chars.map { |c| CHARS[c] }.join('')
  end

  def self.part1(input)
    bits = Packet.new to_bits input
    bits.part1
  end

  def self.part2(input)
    bits = Packet.new to_bits input
    bits.eval
  end
end
