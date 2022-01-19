# https://adventofcode.com/2016/day/5

require 'digest'

class Day05
  def self.part1(input)
    md5 = Digest::MD5.new
    password = []
    i = 0
    8.times do
      loop do
        md5.reset
        md5 << "#{input}#{i}"
        i += 1
        break if md5.hexdigest[0,5] == '00000'
      end
      password << md5.hexdigest[5]
    end
    password.join('')
  end

  def self.part2(input)
    md5 = Digest::MD5.new
    password = []
    i = 0
    while password.count { |c| c } < 8
      loop do
        md5.reset
        md5 << "#{input}#{i}"
        i += 1
        break if md5.hexdigest[0,5] == '00000'
      end
      next unless ('0'..'7').include? md5.hexdigest[5]
      pos = md5.hexdigest[5].to_i
      password[pos] ||= md5.hexdigest[6]
    end
    password.join('')
  end
end
