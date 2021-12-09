def unique_digit_counts_8(input)
  count = 0
  input.each do |line|
    (_, number) = line.split(/ \| /)
    words = number.split(/ /)
    words.each do |word|
      case word.size
      when 2..4, 7
        count += 1
      end
    end
  end
  count
end

def solve_number(number, lookup)
  result = 0
  number.each do |word|
    result *= 10
    result += lookup[word]
  end
  result
end

def initialize_lookups(digits, lookup, inverse)
  digits.each do |digit|
    case digit.size
    when 2
      lookup[digit] = 1
      inverse[1] = digit
    when 3
      lookup[digit] = 7
      inverse[7] = digit
    when 4
      lookup[digit] = 4
      inverse[4] = digit
    when 7
      lookup[digit] = 8
      inverse[8] = digit
    end
  end
  solve_235(digits, lookup, inverse)
  solve_069(digits, lookup, inverse)
end

def solve_235(digits, lookup, inverse)
  digits.filter { |d| d.size == 5 }.each do |digit|
    three = true
    inverse[7].each_char { |c| three &&= digit.include? c }
    if three
      lookup[digit] = 3
      inverse[3] = digit
      next
    end

    five = true
    (inverse[4].chars - inverse[1].chars).each { |c| five &&= digit.include? c }
    if five
      lookup[digit] = 5
      inverse[5] = digit
      next
    end

    lookup[digit] = 2
    inverse[2] = digit
  end
end

def solve_069(digits, lookup, inverse)
  digits.filter { |d| d.size == 6 }.each do |digit|
    # 1 is in 0 and 9, not 6
    zero_or_nine = true
    inverse[1].each_char { |c| zero_or_nine &&= digit.include? c }
    unless zero_or_nine
      lookup[digit] = 6
      inverse[6] = digit
      next
    end

    nine = true
    inverse[4].each_char { |c| nine &&= digit.include? c }
    if nine
      lookup[digit] = 9
      inverse[9] = digit
      next
    end

    lookup[digit] = 0
    inverse[0] = digit
  end
end

def solve_digits_line(line)
  (digits, number) = line.split(/ \| /)
  digits = digits.split(/ /).map { |w| w.chars.sort.join('') }
  number = number.split(/ /).map { |w| w.chars.sort.join('') }
  lookup = {}
  inverse = Array.new(10)

  initialize_lookups(digits, lookup, inverse)

  solve_number number, lookup
end

def sum_of_digits_8(input)
  input.sum do |line|
    solve_digits_line(line)
  end
end
