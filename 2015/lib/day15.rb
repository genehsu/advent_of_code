# https://adventofcode.com/2015/day/15

class Day15

  class Ingredient
    attr_reader :name, :capacity, :durability, :flavor, :texture, :calories

    def initialize(name:, capacity:, durability:, flavor:, texture:, calories:)
      @name = name
      @capacity = capacity
      @durability = durability
      @flavor = flavor
      @texture = texture
      @calories = calories
    end

    def self.for(line)
      /^(?<ingredient>\w+): capacity (?<capacity>-?\d+), durability (?<durability>-?\d+), flavor (?<flavor>-?\d+), texture (?<texture>-?\d+), calories (?<calories>\d+)/ =~ line
      Ingredient.new(
        name: ingredient.to_sym,
        capacity: capacity.to_i,
        durability: durability.to_i,
        flavor: flavor.to_i,
        texture: texture.to_i,
        calories: calories.to_i,
      )
    end
  end

  class MixingBowl
    attr_reader :ingredients

    def initialize(ingredients)
      @ingredients = ingredients
    end

    def score(quantities)
      capacity = 0
      durability = 0
      flavor = 0
      texture = 0

      quantities.each_with_index do |quantity, i|
        ingredient = ingredients[i]
        capacity   += quantity * ingredient.capacity
        durability += quantity * ingredient.durability
        flavor     += quantity * ingredient.flavor
        texture    += quantity * ingredient.texture
      end

      (capacity > 0 ? capacity : 0) *
        (durability > 0 ? durability : 0) *
        (flavor > 0 ? flavor : 0) *
        (texture > 0 ? texture : 0)
    end

    def calories(quantities)
      calories = 0
      quantities.each_with_index do |value, i|
        ingredient = ingredients[i]
        calories += value * ingredient.calories
      end
      calories
    end

    def initial_quantities
      initial_quantity = capacity / ingredients.size
      quantities = [initial_quantity] * ingredients.size
      quantities[0] += 100 % ingredients.size
      quantities
    end

    def capacity
      100
    end
  end

  def self.parse(input)
    input.map do |line|
      Ingredient.for line
    end
  end

  def self.initial_guess(ingredients)
    initial_quantity = 100 / ingredients.size
    quantities = [initial_quantity] * ingredients.size
    quantities[0] += 100 % ingredients.size
    quantities
  end

  def self.part1_simple(input)
    ingredients = parse input
    bowl = MixingBowl.new ingredients
    explore_combos(bowl, ingredients.size) { |bowl, quantities| true }
  end

  def self.part1(input)
    ingredients = parse input
    bowl = MixingBowl.new ingredients

    quantities = bowl.initial_quantities
    size = ingredients.size
    loop do
      changed = false
      current = bowl.score quantities
      (0...size).to_a.permutation(2).each do |combo|
        loop do
          new_quantities = quantities.dup
          new_quantities[combo[0]] += 1
          new_quantities[combo[1]] -= 1
          attempt = bowl.score new_quantities
          if attempt > current
            current = attempt
            changed = true
            quantities = new_quantities
          else
            break
          end
        end
      end
      break unless changed
    end
    bowl.score quantities
  end

  def self.explore_combos(bowl, n, combo = [], &block)
    return -1 if combo.sum > bowl.capacity
    last = bowl.capacity - combo.sum

    if n == 1
      # the last number is the capacity minus the sum of the quantities
      quantities = combo + [last]
      if yield(bowl, quantities)
        bowl.score(quantities)
      else
        -1
      end

    else
      combo = combo + [0]
      (0..last).map do |i|
        combo[-1] = i
        explore_combos(bowl, n-1, combo, &block)
      end.max
    end
  end

  def self.part2(input)
    ingredients = parse input
    bowl = MixingBowl.new ingredients
    explore_combos(bowl, ingredients.size) do |bowl, quantities|
      bowl.calories(quantities) == 500
    end
  end
end
