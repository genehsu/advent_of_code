class PriorityQueue
  attr_reader :data

  def initialize
    @data = []
  end

  def <<(v)
    @data << v
    swim(size - 1)
    self
  end

  def pop
    remove_at(0)
  end

  def size
    @data.size
  end

  def empty?
    @data.empty?
  end

  def swap(i, j)
    @data[i], @data[j] = @data[j], @data[i]
  end

  def less(i, j)
    @data[i].first < @data[j].first
  end

  def swim(i)
    parent = (i - 1) / 2
    while i > 0 && less(i, parent)
      swap(i, parent)
      i = parent
      parent = (i - 1)/ 2
    end
  end

  def sink(i)
    while (j = min_child(i)) >= 1
      swap(i, j)
      i = j
    end
  end

  def min_child(i)
    left = 2 * i + 1
    right = left + 1
    return -1 if left >= size
    return right if right < size && less(right, left) && less(right, i)

    less(left, i) ? left : -1
  end

  def remove_at(k)
    return if empty?

    last_index = size - 1
    swap(k, last_index)
    value = @data.pop
    return value if k == last_index

    elem = @data[k]
    sink(k)
    swim(k) if @data[k].eql? elem

    value
  end
end
