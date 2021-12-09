def decode_3a(input)
  counts = nil
  gamma_rate = 0
  epsilon_rate = 0

  counts = Array.new(input.first.size) { Array.new(2, 0) }
  input.each do |line|
    line.size.times do |i|
      bit  = line[i].to_i
      counts[i][bit] += 1
    end
  end

  counts.each_with_index do |(zero, one), i|
    gamma_rate <<= 1
    epsilon_rate <<= 1
    if zero > one
      epsilon_rate |= 1
    else
      gamma_rate |= 1
    end
  end
  [gamma_rate, epsilon_rate]
end

def calc_o2_rating(input, index)
  counts = { "0" => 0, "1" => 0 }
  input.each { |d| counts[d[index]] += 1 }
  if counts["0"] > counts["1"]
    target = "0"
  else
    target = "1"
  end
  input = input.select { |d| d[index] == target }
  return input.first.to_i(2) if input.size == 1
  calc_o2_rating(input, index+1)
end

def calc_co2_rating(input, index)
  counts = { "0" => 0, "1" => 0 }
  input.each { |d| counts[d[index]] += 1 }
  if counts["1"] < counts["0"]
    target = "1"
  else
    target = "0"
  end
  input = input.select { |d| d[index] == target }
  return input.first.to_i(2) if input.size == 1
  calc_co2_rating(input, index+1)
end

def decode_3b(input)
  o2 = calc_o2_rating(input, 0)
  co2 = calc_co2_rating(input, 0)
  [o2, co2]
end
