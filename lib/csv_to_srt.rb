# frozen_string_literal: true

class CsvToSrt
  class << self
    def run(options)
      source = SourceCSV.new(options[:file_name])
      srt = SRT.new(SRT.extract_languages(source.csv.headers))

      source.csv.each_with_index do |row, idx|
        srt.append(
          index: idx,
          start_time: SRT.parse_time(row, :start),
          end_time: SRT.parse_time(row, :end),
          texts: srt.languages.map { |lang| [lang, row["text_#{lang}"]] }.to_h
        )
      end

      srt.to_file!(source.folder, source.name)
    end
  end
end
