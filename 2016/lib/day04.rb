# https://adventofcode.com/2016/day/4

class Day04
  def self.parse(line)
    /(?<name>[a-z-]+)-(?<sector_id>\d+)\[(?<checksum>[a-z]{5})\]/ =~ line
    counts = name.chars.tally
    counts.delete("-")
    calcsum = counts.sort_by { |k, v| [-v, k] }
    calcsum = calcsum[0,5].map { |k, v| k }.join('')
    if calcsum == checksum
      [name, sector_id.to_i]
    else
      [name, 0]
    end
  end

  def self.part1(input)
    input
      .map { |line| parse(line)[1] }
      .sum
  end

  CHR_BASE = 'a'.ord

  def self.decrypt(name, serial_id)
    name.chars.map do |c|
      if c == '-'
        ' '
      else
        offset = (c.ord - CHR_BASE + serial_id) % 26
        (CHR_BASE + offset).chr
      end
    end.join('')
  end

  def self.part2(input)
    input.each do |line|
      name, serial_id = parse line
      next if serial_id == 0
      room = decrypt(name, serial_id)
      next unless room == "northpole object storage"
      return serial_id
    end
  end
end
