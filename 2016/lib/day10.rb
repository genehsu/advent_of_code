# https://adventofcode.com/2016/day/10

class Day10
  class Bot
    attr_accessor :low, :high
    attr_reader :values

    def initialize(index)
      @index = index
      @values = []
    end

    def <<(value)
      v = value.to_i
      @values << v
      @values.sort!
      eval if @values.size == 2
      self
    end

    def eval
      low << @values[0] if low
      high << @values[1] if high
    end
  end

  class BotList
    def initialize
      @bots = []
    end

    def [](index)
      @bots[index.to_i] ||= Bot.new(index.to_i)
    end

    def values
      @bots.map(&:values)
    end
  end

  class Output
    attr_reader :value

    def initialize(index)
      @index = index
      @values = nil
    end

    def <<(value)
      @value = value.to_i
    end
  end

  class OutputList
    def initialize
      @outputs = []
    end

    def [](index)
      @outputs[index.to_i] ||= Output.new(index.to_i)
    end

    def values
      @outputs.map(&:value)
    end
  end

  def self.parse(input)
    bots = BotList.new
    outputs = OutputList.new
    # Do the bot relations first
    input.each do |line|
      if /^bot (?<index>\d+) gives low to (?<lowtype>bot|output) (?<low>\d+) and high to (?<hightype>bot|output) (?<high>\d+)/ =~ line
        bot = bots[index]
        bot.low = lowtype == 'bot' ? bots[low] : outputs[low]
        bot.high = hightype == 'bot' ? bots[high] : outputs[high]
      end
    end
    # Then process the values
    input.each do |line|
      if /^value (?<value>\d+) goes to bot (?<index>\d+)/ =~ line
        bot = bots[index]
        bot << value
      end
    end
    [bots, outputs]
  end

  def self.part1(input, comparison)
    bots, outputs = parse input
    bots.values.find_index(comparison)
  end

  def self.part2(input)
    bots, outputs = parse input
    outputs.values[0,3].reduce(1, :*)
  end
end
