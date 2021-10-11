# frozen_string_literal: true

require 'optparse'
require 'require_all'

require_all 'lib/**/*.rb'

desc 'Convert CSV file given in parameter to SRT file(s)'
task :csv_to_srt do
  options = {}

  parser = OptionParser.new do |opts|
    opts.banner = 'Usage: rake csv_to_srt [options]'

    opts.on('-f', '--file FILE', 'Add source file') do |file_name|
      options[:file_name] = file_name
    end
    opts.on('-h', '--help', 'Prints help') do
      puts opts
      exit 0
    end

    opts.order!(ARGV) {}
  end
  parser.parse!

  raise 'Missing file. Use "rake csv_to_srt -- -h" for help.' if options.empty?

  CsvToSrt.run(options)

  exit 0
end
