# https://adventofcode.com/2021/day/22

class Day22

  class Core
    attr_reader :volumes

    def initialize(limit = nil)
      @limit = Cuboid.new(limit, limit, limit) if limit
      @volumes = []
    end

    def <<(line)
      action, volume = *line
      volume.limit = @limit.dx if @limit
      if action == 'on'
        self + volume
      elsif action == 'off'
        self - volume
      end
      self
    end

    def +(volume)
      self.tap do
        sub_volumes = [volume]

        intersections = @volumes.select { |v| volume.intersect? v }
        intersections.each do |original|
          to_slice = sub_volumes.select { |v| v.intersect? original }
          sub_volumes -= to_slice
          to_slice.each do |v|
            v.remove(original).each do |remainder|
              sub_volumes << remainder
            end
          end
        end

        sub_volumes.each do |v|
          next if @limit && !@limit.intersect?(v)
          @volumes << v
        end
      end
    end

    def -(volume)
      self.tap do
        @volumes.map! do |original|
          if volume.intersect? original
            original.remove(volume)
              .select { |v| v.size > 0 }
          else
            original
          end
        end.flatten!
      end
    end

    def count
      @volumes.sum(&:size)
    end
  end

  class Cuboid
    attr_reader :dx, :dy, :dz
    attr_accessor :limit

    def initialize(x_range, y_range, z_range)
      @dx = x_range
      @dy = y_range
      @dz = z_range
      @limit = nil
    end

    def ==(other)
      dx == other.dx &&
        dy == other.dy &&
        dz == other.dz
    end

    alias_method :eql?, :==

    def intersect?(other)
      intersect_1d(dx, other.dx) &&
        intersect_1d(dy, other.dy) &&
        intersect_1d(dz, other.dz)
    end

    def cover?(other)
      dx.cover?(other.dx) &&
        dy.cover?(other.dy) &&
        dz.cover?(other.dz)
    end

    def remove(other)
      xr = partition_range(dx, other.dx)
      yr = partition_range(dy, other.dy)
      zr = partition_range(dz, other.dz)
      replacement_volumes = []
      replacement_volumes << Cuboid.new(   dx,    dy, zr[0])
      replacement_volumes << Cuboid.new(   dx, yr[0], zr[1])
      replacement_volumes << Cuboid.new(xr[0], yr[1], zr[1])
      replacement_volumes << Cuboid.new(xr[2], yr[1], zr[1])
      replacement_volumes << Cuboid.new(   dx, yr[2], zr[1])
      replacement_volumes << Cuboid.new(   dx,    dy, zr[2])
      replacement_volumes.reject { |v| v.size == 0 }
    end

    def size
      if limit
        xr = common_range(limit, dx)
        yr = common_range(limit, dy)
        zr = common_range(limit, dz)
        return 0 unless [xr, yr, zr].all?
        xr.size * yr.size * zr.size
      else
        @dx.size * @dy.size * @dz.size
      end
    end

    private

    def intersect_1d(axis, other)
      axis.include?(other.begin) ||
        axis.include?(other.end) ||
        other.cover?(axis)
    end

    def common_range(src, dest)
      return unless intersect_1d(src, dest)
      return src if dest.cover?(src)

      r1 = src.include?(dest.begin) ? dest.begin : src.begin
      r2 = src.include?(dest.end) ? dest.end : src.end
      r1..r2
    end

    def partition_range(src, remove)
      cut = common_range(src, remove)
      return unless cut

      [src.begin..cut.begin-1, cut, cut.end+1..src.end]
    end
  end

  def self.parse_range(string)
    /[xyz]=(?<first>-?\d+)..(?<last>-?\d+)/ =~ string
    first.to_i..last.to_i
  end

  def self.parse(line)
    action, scope = line.split(/ /)
    ranges = scope.split(/,/)
    x_range = parse_range(ranges[0])
    y_range = parse_range(ranges[1])
    z_range = parse_range(ranges[2])
    [action, Cuboid.new(x_range, y_range, z_range)]
  end

  def self.part1(input)
    core = Core.new(-50..50)
    input.each do |line|
      core << parse(line)
    end
    core.count
  end

  def self.part2(input)
    core = Core.new
    input.each do |line|
      core << parse(line)
    end
    core.count
  end
end
