# https://adventofcode.com/2015/day/15
# --- Day 15: Science for Hungry People ---

class Day15
  # Today, you set out on the task of perfecting your milk-dunking cookie
  # recipe. All you have to do is find the right balance of ingredients.
  #
  # Your recipe leaves room for exactly 100 teaspoons of ingredients. You make
  # a list of the remaining ingredients you could use to finish the recipe
  # (your puzzle input) and their properties per teaspoon:
  #
  #     capacity (how well it helps the cookie absorb milk)
  #     durability (how well it keeps the cookie intact when full of milk)
  #     flavor (how tasty it makes the cookie)
  #     texture (how it improves the feel of the cookie)
  #     calories (how many calories it adds to the cookie)
  #
  # You can only measure ingredients in whole-teaspoon amounts accurately, and
  # you have to be accurate so you can reproduce your results in the future.
  # The total score of a cookie can be found by adding up each of the
  # properties (negative totals become 0) and then multiplying together
  # everything except calories.
  #
  # For instance, suppose you have these two ingredients:
  #
  # Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
  # Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
  #
  # Then, choosing to use 44 teaspoons of butterscotch and 56 teaspoons of
  # cinnamon (because the amounts of each ingredient must add up to 100) would
  # result in a cookie with the following properties:
  #
  #     A capacity of 44*-1 + 56*2 = 68
  #     A durability of 44*-2 + 56*3 = 80
  #     A flavor of 44*6 + 56*-2 = 152
  #     A texture of 44*3 + 56*-1 = 76
  #
  # Multiplying these together (68 * 80 * 152 * 76, ignoring calories for now)
  # results in a total score of 62842880, which happens to be the best score
  # possible given these ingredients. If any properties had produced a negative
  # total, it would have instead become zero, causing the whole score to
  # multiply to zero.
  #
  # Given the ingredients in your kitchen and their properties, what is the
  # total score of the highest-scoring cookie you can make?

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

  # Your cookie recipe becomes wildly popular! Someone asks if you can make
  # another recipe that has exactly 500 calories per cookie (so they can use it
  # as a meal replacement). Keep the rest of your award-winning process the
  # same (100 teaspoons, same ingredients, same scoring system).
  #
  # For example, given the ingredients above, if you had instead selected 40
  # teaspoons of butterscotch and 60 teaspoons of cinnamon (which still adds to
  # 100), the total calorie count would be 40*8 + 60*3 = 500. The total score
  # would go down, though: only 57600000, the best you can do in such trying
  # circumstances.
  #
  # Given the ingredients in your kitchen and their properties, what is the
  # total score of the highest-scoring cookie you can make with a calorie total
  # of 500?

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
