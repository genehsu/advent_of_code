module AocInput
  def self.read(day)
    index = "%02d" % day
    filename = "day#{index}.txt"
    path = File.join('input', filename)
    File.readlines(path, chomp: true)
  end
end
