# https://adventofcode.com/2021/day/20

require_relative '../../lib/util'

class Day20

  class Image
    attr_reader :algo

    PADDING = 2

    def initialize(input)
      @algo = input.shift
      input.shift
      @grid = []
      input.each do |line|
        row = 0
        line.size.times do |i|
          row |= 1 << i if line[i] == '#'
        end
        @grid << row
      end
      PADDING.times { pad 0 }
    end

    FLIP3 = {
      0 => 0,
      1 => 4,
      2 => 2,
      3 => 6,
      4 => 1,
      5 => 5,
      6 => 3,
      7 => 7,
    }.freeze

    def pad(bit)
      size = @grid.size
      if bit == 0
        @grid.unshift 0
        @grid.map! { |row| row << 1 }
        @grid << 0
      else
        border_row = (1 << size + PADDING) - 1
        frame_row = (1 << size + PADDING) - (1 << size) | (1 << PADDING) - 1
        @grid.unshift 0
        @grid.map! { |row| (row << 1) | frame_row }
        @grid << border_row
        PADDING.times do |i|
          @grid[i] = border_row
          @grid[-1-i] = border_row
        end
      end
    end

    def enhance
      pad @grid[1][1]
      new_grid = Array.new(@grid.size, 0)
      max_index = @grid.size - 3
      (0..max_index).each do |y|
        (0..max_index).each do |x|
          n = FLIP3[@grid[y][x,3]]
          n <<= 3
          n += FLIP3[@grid[y+1][x,3]]
          n <<= 3
          n += FLIP3[@grid[y+2][x,3]]
          if @algo[n] == '#'
            new_grid[y+1] |= 1 << x+1
          end
        end
      end
      @grid = new_grid
    end

    def to_s
      @grid.map do |row|
        (0...@grid.size).map { |i| row[i] == 1 ? '#' : '.' }.join('')
      end.join("\n")
    end

    def count_lit_pixels
      mask = (1 << @grid.size - PADDING) - 1
      (1...@grid.size-1).map do |i|
        row = @grid[i] >> PADDING
        Util.count_bits(row & mask)
      end.sum
    end
  end

  def self.part1(input)
    image = Image.new input
    image.enhance
    image.enhance
    image.count_lit_pixels
  end

  def self.part2(input)
    image = Image.new input
    50.times { image.enhance }
    image.count_lit_pixels
  end
end
