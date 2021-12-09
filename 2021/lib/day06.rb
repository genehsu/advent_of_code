def grow_fish_6(input, days)
  state = Array.new(9,0)
  input.each { |n| state[n] += 1 }

  days.times do
    n = state.shift
    state[6] += n
    state << n
  end
  state.sum
end
