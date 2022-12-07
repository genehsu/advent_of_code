# https://adventofcode.com/2022/day/7

class Day07
  class Node
    attr_accessor :size
    attr :type, :path, :parent, :children

    def initialize(parent:, type:, path:, children: [], size: nil)
      @parent = parent
      @type = type
      @path = path
      @children = children
      @size = size
    end

    def depth
      parent ? parent.depth + 1 : 0
    end

    def to_s
      print '  ' * depth
      print path
      if type == :dir
        print '/'
      end
      puts " (#{size})"
      children.each { |child| child.to_s }
    end
  end

  def self.parse(input)
    root = Node.new(parent: nil, type: :dir, path: '/')
    current = nil
    directories = [root]
    input.each do |line|
      if line == '$ cd /'
        current = root
      elsif line == '$ cd ..'
        current.size = current.children.sum { |child| child.size }
        current = current.parent
      elsif /\A\$ cd (?<path>.+)\z/ =~ line
        current = current.children.find { |child| child.path == path }
        directories << current
      elsif line == '$ ls'
        # Ignore
      elsif /\Adir (?<path>.+)\z/ =~ line
        current.children << Node.new(parent: current, type: :dir, path: path)
      elsif /\A(?<size>\d+) (?<path>.+)\z/ =~ line
        current.children << Node.new(parent: current, type: :file, path: path, size: size.to_i)
      end
    end
    while current != root
      current.size = current.children.sum { |child| child.size }
      current = current.parent
    end
    current.size = current.children.sum { |child| child.size }
    directories
  end

  def self.part1(input)
    directories = parse(input)
    directories.map { |dir| dir.size }
      .select { |size| size <= 100000 }
      .sum
  end

  def self.part2(input)
    directories = parse(input)
    root = directories.first
    min_size = 30_000_000 - (70_000_000 - root.size)
    directories.map { |dir| dir.size }
      .select { |size| size >= min_size }.min
  end
end
