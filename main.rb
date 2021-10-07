$LOAD_PATH.unshift File.expand_path('lib', __dir__)

require 'csv'
require 'srt'

filename = ARGV.first

unless filename
  raise 'Please put the CSV file path as argument!'
end

csv = CSV.parse(File.read(filename), headers: true)
srt = SRT.new(:id, :en)

csv.each_with_index do |row, idx|
  srt.append(
    index: idx,
    start_time: SRT.parse_time(row, :start),
    end_time: SRT.parse_time(row, :end),
    texts: srt.languages.map { |lang| [lang, row["text_#{lang}"]] }.to_h
  )
end

file_path = filename.split('/')
target_path = file_path[0...-1].join('/')
target_name = file_path[-1].split('.').first

srt.to_file!(target_path, target_name)
