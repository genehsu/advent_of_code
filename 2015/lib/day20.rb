# https://adventofcode.com/2015/day/20

class Day20

  def self.count_presents(n)
    count = 0
    limit = Math.sqrt(n).to_i
    (1..limit).each do |k|
      next unless n % k == 0
      m = n / k
      count += k
      next if m == k
      count += m
    end
    count * 10
  end

  def self.brute_force_factorization(input)
    input.times do |n|
      f = count_presents(n)
      return n if f > input
    end
  end

  def self.brute_force_memory_use(input)
    houses = Array.new(input/10+1, 10)
    (2..houses.size).each do |elf|
      presents = elf * 10
      elf.step(by: elf, to: houses.size-1) do |house|
        houses[house] += presents
      end
    end
    houses.size.times do |house|
      return house if houses[house] >= input
    end
  end

  def self.part1(input)
    # brute_force_factorization(input)
    brute_force_memory_use(input)
  end

  def self.count_presents2(n)
    count = 0
    limit = Math.sqrt(n).to_i
    (1..limit).each do |k|
      next unless n % k == 0
      m = n / k
      count += k if m <= 50
      next if m == k
      count += m if k <= 50
    end
    count * 11
  end

  def self.brute_force_factorization2(input)
    input.times do |n|
      f = count_presents2(n)
      return n if f > input
    end
  end

  def self.brute_force_memory_use2(input)
    last_house = input / 10
    houses = Array.new(last_house+1, 10)
    (2..last_house).each do |elf|
      presents = elf * 11
      limit = elf * 50
      limit = last_house if limit > last_house
      elf.step(by: elf, to: limit) do |house|
        houses[house] += presents
      end
    end
    houses.size.times do |house|
      return house if houses[house] >= input
    end
  end

  def self.part2(input)
    # brute_force_factorization2(input)
    brute_force_memory_use2(input)
  end
end
