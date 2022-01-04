module AocInput
  def self.read(day)
    index = "%02d" % day
    filename = "day#{index}.txt"
    path = File.join('input', filename)
    File.readlines(path, chomp: true)
  end

  def self.read_ints(day)
    read(day).map(&:to_i)
  end

  def self.read_line(day)
    read(day).first
  end

  def self.read_int_line(day)
    read(day).first.split(/,/).map(&:to_i)
  end
end
