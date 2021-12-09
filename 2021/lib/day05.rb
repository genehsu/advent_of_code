def draw_field_hv(input)
  field = [].tap do |field|
    input.each do |line|
      /\A(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)\Z/ =~ line
      next unless (x1 == x2) || (y1 == y2)
      x1, y1, x2, y2 = [x1, y1, x2, y2].map(&:to_i)
      x1, x2 = [x1, x2].sort
      y1, y2 = [y1, y2].sort
      (x1..x2).each do |x|
        field[x] ||= []
        (y1..y2).each do |y|
          field[x][y] ||= 0
          field[x][y] += 1
        end
      end
    end
  end
end

def draw_field_hvd(input)
  field = [].tap do |field|
    input.each do |line|
      /\A(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)\Z/ =~ line
      x1, y1, x2, y2 = [x1, y1, x2, y2].map(&:to_i)
      next unless (x1 == x2) || (y1 == y2) || (x1 - x2).abs == (y1 - y2).abs
      if x1 == x2 || y1 == y2
        x1, x2 = [x1, x2].sort
        y1, y2 = [y1, y2].sort
        (x1..x2).each do |x|
          field[x] ||= []
          (y1..y2).each do |y|
            field[x][y] ||= 0
            field[x][y] += 1
          end
        end
      else
        if x1 > x2
          x1, x2, y1, y2 = x2, x1, y2, y1
        end
        direction = y2 <=> y1
        (x1..x2).each do |x|
          y = y1 + (x - x1) * direction
          field[x] ||= []
          field[x][y] ||= 0
          field[x][y] += 1
        end
      end
    end
  end
end

def count_overlaps(field)
  field.sum do |line|
    line && line.count { |cell| cell && cell > 1 } || 0
  end
end

def dump_field(field)
  field.first.size.times do |y|
    field.first.size.times do |x|
      print field[x][y] || '.'
    end
    puts
  end
end

def count_overlaps_5a(input)
  field = draw_field_hv(input)
  count_overlaps(field)
end

def count_overlaps_5b(input)
  field = draw_field_hvd(input)
  count_overlaps(field)
end
