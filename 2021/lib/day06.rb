# https://adventofcode.com/2021/day/6

class Day06
  def self.grow_fish(input, days)
    state = Array.new(9,0)
    input.each { |n| state[n] += 1 }

    days.times do
      state.rotate!
      state[6] += state[8]
    end
    state.sum
  end
end
