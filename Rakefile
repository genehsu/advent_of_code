require 'fileutils'

task default: :download

task :download, [:year,:day] do |t, args|
  year = args.year || Time.now.utc.year
  day = args.day || Time.now.utc.day
  day = "%02d" % day.to_i
  year = year.to_i - 1 unless Time.now.utc.month == 12
  sh "aocdl -output #{year}/input/day#{day}.txt -day #{day} -year #{year}"
end

task :download_all, [:year] do |t, args|
  raise "Must specify year" unless args.year
  dir = File.join(args.year, 'input')
  FileUtils.mkdir_p(dir, verbose: true)
  ('01'..'25').each do |day|
    sh "aocdl -output #{dir}/day#{day}.txt -day #{day} -year #{args.year}"
  end
end
