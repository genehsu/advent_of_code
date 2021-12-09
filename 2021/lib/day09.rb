def create_area_from_input(input)
  area = []
  input.each do |line|
    row = line.split(//).map(&:to_i)
    row.unshift 9
    row << 9
    area << row
  end
  border_row = Array.new(area.first.size, 9)
  area.unshift border_row
  area << border_row
end

def sum_low_points(input)
  area = create_area_from_input input

  sum = 0
  (1..area.size-2).each do |x|
    row = area[x]
    (1..row.size-2).each do |y|
      current = area[x][y]
      min_adjacent = [
        area[x+1][y],
        area[x-1][y],
        area[x][y+1],
        area[x][y-1]
      ].min
      if current < min_adjacent
        sum += current + 1
      end
    end
  end
  sum
end

def explore_basin(area, x, y)
  stack = [[x,y]]
  size =  0
  while (x,y = stack.pop)
    next if area[x][y] == 9
    size += 1
    area[x][y] = 9
    [[x+1,y],
     [x-1,y],
     [x,y+1],
     [x,y-1],
    ].each do |x1,y1|
      stack << [x1,y1] unless area[x1][y1] == 9
    end
  end
  size
end

def count_basins_9(input)
  area = create_area_from_input input

  basins = []
  (1..area.size-2).each do |x|
    row = area[x]
    (1..row.size-2).each do |y|
      current = area[x][y]
      if current < 9
        basins << explore_basin(area, x, y)
      end
    end
  end
  basins.sort[-3,3].reduce(&:*)
end
