# https://adventofcode.com/2016/day/8

class Day08
  class Display
    def initialize
      @screen = Array.new(6) { Array.new(50, '.') }
    end

    def to_s
      @screen.map { |a| a.join('') }.join("\n")
    end

    def rect(a, b)
      b.times do |y|
        a.times do |x|
          @screen[y][x] = '#'
        end
      end
    end

    def rotate_column(a, b)
      temp = @screen.map { |line| line[a] }
      temp.rotate(6-b).each_with_index do |c, i|
        @screen[i][a] = c
      end
    end

    def rotate_row(a, b)
      @screen[a] = @screen[a][-b, b] + @screen[a][0,50-b]
    end

    def lit
      @screen.map { |line| line.count('#') }.sum
    end

    def self.parse(input)
      display = Display.new
      input.each do |line|
        /(?<command>rect|rotate row y=|rotate column x=) ?(?<a>\d+)(?:x| by )(?<b>\d+)/ =~ line
        a, b = [a, b].map(&:to_i)
        case command
        when 'rect'
          display.rect(a, b)
        when 'rotate row y='
          display.rotate_row(a, b)
        when 'rotate column x='
          display.rotate_column(a, b)
        end
      end
      display
    end
  end

  def self.part1(input)
    display = Display.parse input
    puts display
    display.lit
  end
end
