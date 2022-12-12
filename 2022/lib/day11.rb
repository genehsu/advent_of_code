# https://adventofcode.com/2022/day/11

class Day11
  class Game
    def initialize
      @monkeys = {}
      @lcm = 1
    end

    def add(monkey)
      @monkeys[monkey.key] = monkey
      @lcm *= monkey.divisor
      @monkeys
    end

    def round(part1=true)
      @monkeys.each do |_, monkey|
        output = monkey.take_turn(@lcm, part1)
        output.each do |key, items|
          @monkeys[key].add_items items
        end
      end
    end

    def print_monkeys
      pp @monkeys.values.map(&:to_s)
    end

    def monkey_business
      @monkeys.values.map(&:activity).max(2).reduce(&:*)
    end
  end

  class Monkey
    attr_reader :activity, :divisor, :key

    def initialize(key, items, operator, amount, divisor, true_target, false_target)
      @key = key
      @items = items
      @operation = case operator
                   when '*'
                     amount ? ->(x) { x * amount } : ->(x) { x * x }
                   when '+'
                     amount ? ->(x) { x + amount } : ->(x) { x + x }
                   end
      @divisor = divisor
      @true_target = true_target
      @false_target = false_target
      @activity = 0
    end

    def take_turn(lcm, part1=true)
      output = {
        @true_target => [],
        @false_target => [],
      }

      @items.each do |item|
        item = @operation.call(item)
        item /= 3 if part1
        item %= lcm
        if item % @divisor == 0
          output[@true_target] << item
        else
          output[@false_target] << item
        end
        @activity += 1
      end
      @items = []

      output
    end

    def add_items(items)
      @items += items
    end

    def to_s
      "#{@key}: #{@activity} #{@items}"
    end
  end

  def self.parse_monkey(input, index)
    /\AMonkey (?<key>\d+):\z/ =~ input[index]
    /\A  Starting items: (?<item_list>[\d, ]+)\z/ =~ input[index + 1]
    /\A  Operation: new = old (?<operator>[*+]) (?<amount>\d+|old)\z/ =~ input[index + 2]
    /\A  Test: divisible by (?<test>\d+)\z/ =~ input[index + 3]
    /\A    If true: throw to monkey (?<true_target>\d+)\z/ =~ input[index + 4]
    /\A    If false: throw to monkey (?<false_target>\d+)\z/ =~ input[index + 5]
    items = item_list.split(/, /).map(&:to_i)
    divisor = test.to_i
    amount = amount =~ /\d/ ? amount.to_i : nil
    Monkey.new(key, items, operator, amount, divisor, true_target, false_target)
  end

  def self.parse(input)
    Game.new.tap do |game|
      index = 0
      while index < input.size
        monkey = parse_monkey(input, index)
        game.add monkey
        index += 7
      end
    end
  end

  def self.part1(input)
    game = parse(input)
    20.times do |i|
      game.round
    end
    # game.print_monkeys
    game.monkey_business
  end

  def self.part2(input)
    game = parse(input)
    10000.times do |i|
      game.round(false)
    end
    # game.print_monkeys
    game.monkey_business
  end
end
