# frozen_string_literal: true

class SRT
  class << self
    def extract_languages(headers)
      headers.select { |header| header.start_with?('text_') }
             .map { |header| header.partition('_').last.to_sym }
    end

    def parse_time(time, prefix)
      TIME_FORMAT % TIMESTAMPS.map do |stamp|
        time["#{prefix[0]}_#{stamp}"].to_s.rjust(2, '0')
      end
    end
  end

  ROW_FORMAT = "%{index}\n%{start_time} --> %{end_time}\n%{text}\n"
  TIME_FORMAT = "%s:%s:%s,%s0"
  TIMESTAMPS = [:hour, :minute, :second, :msecond]

  attr_reader :languages, :subtitle

  def initialize(languages)
    @languages = languages
    @subtitle = {}

    languages.each { |lang| @subtitle[lang] = [] }
  end

  def append(row = {})
    row[:texts].each do |language, text|
      row[:text] = text
      @subtitle[language] << ROW_FORMAT % row
    end
  end

  def to_file!(path, name)
    @subtitle.each do |language, texts|
      File.open("#{path}/#{name}-#{language}.srt", 'w') do |file|
        file.write(texts.join("\n"))
      end
    end
  end
end
