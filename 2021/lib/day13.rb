# https://adventofcode.com/2021/day/13
# --- Day 13: Transparent Origami ---

class Day13
  # You reach another volcanically active part of the cave. It would be nice if
  # you could do some kind of thermal imaging so you could tell ahead of time
  # which caves are too hot to safely enter.
  #
  # Fortunately, the submarine seems to be equipped with a thermal camera! When
  # you activate it, you are greeted with:
  #
  # Congratulations on your purchase! To activate this infrared thermal imaging
  # camera system, please enter the code found on page 1 of the manual.
  #
  # Apparently, the Elves have never used this feature. To your surprise, you
  # manage to find the manual; as you go to open it, page 1 falls out. It's a
  # large sheet of transparent paper! The transparent paper is marked with
  # random dots and includes instructions on how to fold it up (your puzzle
  # input). For example:
  #
  # 6,10
  # 0,14
  # 9,10
  # 0,3
  # 10,4
  # 4,11
  # 6,0
  # 6,12
  # 4,1
  # 0,13
  # 10,12
  # 3,4
  # 3,0
  # 8,4
  # 1,10
  # 2,14
  # 8,10
  # 9,0
  #
  # fold along y=7
  # fold along x=5
  #
  # The first section is a list of dots on the transparent paper. 0,0
  # represents the top-left coordinate. The first value, x, increases to the
  # right. The second value, y, increases downward. So, the coordinate 3,0 is
  # to the right of 0,0, and the coordinate 0,7 is below 0,0. The coordinates
  # in this example form the following pattern, where # is a dot on the paper
  # and . is an empty, unmarked position:
  #
  # ...#..#..#.
  # ....#......
  # ...........
  # #..........
  # ...#....#.#
  # ...........
  # ...........
  # ...........
  # ...........
  # ...........
  # .#....#.##.
  # ....#......
  # ......#...#
  # #..........
  # #.#........
  #
  # Then, there is a list of fold instructions. Each instruction indicates a
  # line on the transparent paper and wants you to fold the paper up (for
  # horizontal y=... lines) or left (for vertical x=... lines). In this
  # example, the first fold instruction is fold along y=7, which designates the
  # line formed by all of the positions where y is 7 (marked here with -):
  #
  # ...#..#..#.
  # ....#......
  # ...........
  # #..........
  # ...#....#.#
  # ...........
  # ...........
  # -----------
  # ...........
  # ...........
  # .#....#.##.
  # ....#......
  # ......#...#
  # #..........
  # #.#........
  #
  # Because this is a horizontal line, fold the bottom half up. Some of the
  # dots might end up overlapping after the fold is complete, but dots will
  # never appear exactly on a fold line. The result of doing this fold looks
  # like this:
  #
  # #.##..#..#.
  # #...#......
  # ......#...#
  # #...#......
  # .#.#..#.###
  # ...........
  # ...........
  #
  # Now, only 17 dots are visible.
  #
  # Notice, for example, the two dots in the bottom left corner before the
  # transparent paper is folded; after the fold is complete, those dots appear
  # in the top left corner (at 0,0 and 0,1). Because the paper is transparent,
  # the dot just below them in the result (at 0,3) remains visible, as it can
  # be seen through the transparent paper.
  #
  # Also notice that some dots can end up overlapping; in this case, the dots
  # merge together and become a single dot.
  #
  # The second fold instruction is fold along x=5, which indicates this line:
  #
  # #.##.|#..#.
  # #...#|.....
  # .....|#...#
  # #...#|.....
  # .#.#.|#.###
  # .....|.....
  # .....|.....
  #
  # Because this is a vertical line, fold left:
  #
  # #####
  # #...#
  # #...#
  # #...#
  # #####
  # .....
  # .....
  #
  # The instructions made a square!
  #
  # The transparent paper is pretty big, so for now, focus on just completing
  # the first fold. After the first fold in the example above, 17 dots are
  # visible - dots that end up overlapping after the fold is completed count as
  # a single dot.
  #
  # How many dots are visible after completing just the first fold instruction
  # on your transparent paper?

  def self.parse(input)
    @graph = []
    @folds = nil
    input.each do |line|
      if line == ""
        @folds = []
        next
      end
      if @folds
        /^fold along (?<axis>[xy])=(?<value>\d+)/ =~ line
        @folds << [axis.to_sym, value.to_i]
      else
        /^(?<x>\d+),(?<y>\d+)/ =~ line
        row = @graph[y.to_i] || 0
        row |= 1 << x.to_i
        @graph[y.to_i] = row
      end
    end
    @graph = @graph.map { |row| row || 0 }
  end

  def self.dump
    size = @graph.map(&:bit_length).max
    @graph.each do |row|
      size.times do |x|
        print row[x] == 1 ? '*' : ' '
      end
      puts
    end
    puts
  end

  def self.fold(axis, value)
    case axis
    when :x
      fold_x(value)
    when :y
      fold_y(value)
    end
  end

  def self.fold_x(value)
    mask = (1 << value + 1) - 1
    @graph = @graph.map do |row|
      before = row & mask
      after = row >> value + 1
      after = after.digits(2)
      while after.size < value
        after << 0
      end
      after = after.join('').to_i(2)
      before | after
    end
  end

  def self.fold_y(value)
    before = @graph[0, value]
    after = @graph[value+1..-1]
    while before.size < after.size
      before << 0
    end
    while after.size < before.size
      after << 0
    end
    after = after.reverse
    @graph = before.zip(after).map { |b,a| a | b }
  end

  def self.count_dots
    @graph.map { |row| count_bits(row) }.sum
  end

  def self.part1(input)
    parse input
    fold *@folds.first
    count_dots
  end

  # Finish folding the transparent paper according to the instructions. The
  # manual says the code is always eight capital letters.
  #
  # What code do you use to activate the infrared thermal imaging camera
  # system?

  def self.part2(input)
    parse input
    @folds.each do |axis, value|
      fold axis, value
    end
    dump
    count_dots
  end

  BIT_LOOKUP = [
    0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
    4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8
  ]

  def self.count_bits(n)
    count = 0
    while n > 0
      count += BIT_LOOKUP[n & 0xff]
      n >>= 8
    end
    count
  end
end