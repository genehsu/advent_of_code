def cumulative_difference(input, anchor)
  input.sum { |n| (n - anchor).abs }
end

def move_crabs_7a(input)
  a = input.min
  b = input.max
  (a..b).map do |n|
    cumulative_difference(input, n)
  end.min
end

def cumulative_difference_expensive(input, anchor)
  input.sum { |n| d = (n - anchor).abs; d * (d+1) / 2 }
end

def move_crabs_7b(input)
  a = input.min
  b = input.max
  (a..b).map do |n|
    cumulative_difference_expensive(input, n)
  end.min
end
