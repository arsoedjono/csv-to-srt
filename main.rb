require 'csv'

filename = ARGV.first

unless filename
  raise 'Please put the CSV file path as argument!'
end

csv = CSV.parse(File.read(filename), headers: true)
srt = {
  'id' => [],
  'en' => []
}

csv.each_with_index do |row, idx|
  time_s = "#{row['s_hour'].to_s.rjust(2, '0')}:#{row['s_minute'].to_s.rjust(2, '0')}:#{row['s_second'].to_s.rjust(2, '0')},#{row['s_msecond'].to_s.rjust(3, '0')}"
  time_e = "#{row['e_hour'].to_s.rjust(2, '0')}:#{row['e_minute'].to_s.rjust(2, '0')}:#{row['e_second'].to_s.rjust(2, '0')},#{row['e_msecond'].to_s.rjust(3, '0')}"

  head = "#{idx + 1}\n#{time_s} --> #{time_e}"

  srt['id'] << "#{head}\n#{row['text_id']}\n"
  srt['en'] << "#{head}\n#{row['text_en']}\n"
end

file_path = filename.split('/')
target_path = file_path[0...-1].join('/')
target_name = file_path[-1].split('.').first

['id', 'en'].each do |lang|
  srt_file = File.new("#{target_path}/#{target_name}-#{lang}.srt", 'w')
  srt_file.puts(srt[lang].join("\n"))
  srt_file.close
end
