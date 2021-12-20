# https://adventofcode.com/2021/day/20
# --- Day 20: Trench Map ---

class Day20
  # With the scanners fully deployed, you turn their attention to mapping the
  # floor of the ocean trench.
  #
  # When you get back the image from the scanners, it seems to just be random
  # noise. Perhaps you can combine an image enhancement algorithm and the input
  # image (your puzzle input) to clean it up a little.
  #
  # For example:
  #
  # ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..##
  # #..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###
  # .######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#.
  # .#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#.....
  # .#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#..
  # ...####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.....
  # ..##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#
  #
  # #..#.
  # #....
  # ##..#
  # ..#..
  # ..###
  #
  # The first section is the image enhancement algorithm. It is normally given
  # on a single line, but it has been wrapped to multiple lines in this example
  # for legibility. The second section is the input image, a two-dimensional
  # grid of light pixels (#) and dark pixels (.).
  #
  # The image enhancement algorithm describes how to enhance an image by
  # simultaneously converting all pixels in the input image into an output
  # image. Each pixel of the output image is determined by looking at a 3x3
  # square of pixels centered on the corresponding input image pixel. So, to
  # determine the value of the pixel at (5,10) in the output image, nine pixels
  # from the input image need to be considered: (4,9), (4,10), (4,11), (5,9),
  # (5,10), (5,11), (6,9), (6,10), and (6,11). These nine input pixels are
  # combined into a single binary number that is used as an index in the image
  # enhancement algorithm string.
  #
  # For example, to determine the output pixel that corresponds to the very
  # middle pixel of the input image, the nine pixels marked by [...] would need
  # to be considered:
  #
  # # . . # .
  # #[. . .].
  # #[# . .]#
  # .[. # .].
  # . . # # #
  #
  # Starting from the top-left and reading across each row, these pixels are
  # ..., then #.., then .#.; combining these forms ...#...#.. By turning dark
  # pixels (.) into 0 and light pixels (#) into 1, the binary number 000100010
  # can be formed, which is 34 in decimal.
  #
  # The image enhancement algorithm string is exactly 512 characters long,
  # enough to match every possible 9-bit binary number. The first few
  # characters of the string (numbered starting from zero) are as follows:
  #
  # 0         10        20        30  34    40        50        60        70
  # |         |         |         |   |     |         |         |         |
  # ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..##
  #
  # In the middle of this first group of characters, the character at index 34
  # can be found: #. So, the output pixel in the center of the output image
  # should be #, a light pixel.
  #
  # This process can then be repeated to calculate every pixel of the output
  # image.
  #
  # Through advances in imaging technology, the images being operated on here
  # are infinite in size. Every pixel of the infinite output image needs to be
  # calculated exactly based on the relevant pixels of the input image. The
  # small input image you have is only a small region of the actual infinite
  # input image; the rest of the input image consists of dark pixels (.). For
  # the purposes of the example, to save on space, only a portion of the
  # infinite-sized input and output images will be shown.
  #
  # The starting input image, therefore, looks something like this, with more
  # dark pixels (.) extending forever in every direction not shown here:
  #
  # ...............
  # ...............
  # ...............
  # ...............
  # ...............
  # .....#..#......
  # .....#.........
  # .....##..#.....
  # .......#.......
  # .......###.....
  # ...............
  # ...............
  # ...............
  # ...............
  # ...............
  #
  # By applying the image enhancement algorithm to every pixel simultaneously,
  # the following output image can be obtained:
  #
  # ...............
  # ...............
  # ...............
  # ...............
  # .....##.##.....
  # ....#..#.#.....
  # ....##.#..#....
  # ....####..#....
  # .....#..##.....
  # ......##..#....
  # .......#.#.....
  # ...............
  # ...............
  # ...............
  # ...............
  #
  # Through further advances in imaging technology, the above output image can
  # also be used as an input image! This allows it to be enhanced a second
  # time:
  #
  # ...............
  # ...............
  # ...............
  # ..........#....
  # ....#..#.#.....
  # ...#.#...###...
  # ...#...##.#....
  # ...#.....#.#...
  # ....#.#####....
  # .....#.#####...
  # ......##.##....
  # .......###.....
  # ...............
  # ...............
  # ...............
  #
  # Truly incredible - now the small details are really starting to come
  # through. After enhancing the original input image twice, 35 pixels are lit.
  #
  # Start with the original input image and apply the image enhancement
  # algorithm twice, being careful to account for the infinite size of the
  # images. How many pixels are lit in the resulting image?

  class Image
    attr_reader :algo

    PADDING = 100

    def initialize(input)
      @algo = input.shift
      input.shift
      @grid = [0] * PADDING
      input.each do |line|
        row = 0
        line.size.times do |i|
          row |= 1 << i if line[i] == '#'
        end
        row <<= PADDING
        @grid << row
      end
      PADDING.times { @grid << 0 }
      @enhanced = 0
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

    def enhance
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
      @enhanced += 1
      @grid = new_grid
    end

    def to_s
      @grid.map do |row|
        (0...@grid.size).map { |i| row[i] == 1 ? '#' : '.' }.join('')
      end.join("\n")
    end

    def count_lit_pixels
      padding = PADDING - @enhanced
      mask = (1 << @grid.size - padding * 2 ) - 1
      (padding...@grid.size-padding).map do |i|
        row = @grid[i] >> padding
        count_bits(row & mask)
      end.sum
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

    def count_bits(n)
      count = 0
      while n > 0
        count += BIT_LOOKUP[n & 0xff]
        n >>= 8
      end
      count
    end
  end

  def self.part1(input)
    image = Image.new input
    image.enhance
    image.enhance
    image.count_lit_pixels
  end

  # You still can't quite make out the details in the image. Maybe you just
  # didn't enhance it enough.
  #
  # If you enhance the starting input image in the above example a total of 50
  # times, 3351 pixels are lit in the final output image.
  #
  # Start again with the original input image and apply the image enhancement
  # algorithm 50 times. How many pixels are lit in the resulting image?

  def self.part2(input)
    image = Image.new input
    50.times { image.enhance }
    image.count_lit_pixels
  end
end