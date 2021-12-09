def count_increasing(input)
  last = nil
  count = 0
  input.each do |current|
    if last && current > last
      count += 1
    end
    last = current
  end
  count
end

def count_window_increasing(input)
  last = nil
  sum = nil
  window = []
  count = 0
  input.each do |current|
    window << current
    window.shift if window.size > 3
    sum = window.sum if window.size == 3
    if last && sum && sum > last
      count += 1
    end
    last = sum
  end
  count
end
