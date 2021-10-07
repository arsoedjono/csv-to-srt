class SRT
  ROW_FORMAT = "%{index}\n%{start_time} --> %{end_time}\n%{text}\n"
  TIME_FORMAT = "%s:%s:%s,%s0"
  TIMESTAMPS = [:hour, :minute, :second, :msecond]

  attr_reader :languages, :subtitle

  def initialize(*languages)
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
      file = File.new("#{path}/#{name}-#{language}.srt", 'w')
      file.puts(texts.join("\n"))
      file.close
    end
  end

  def self.parse_time(time, prefix)
    TIME_FORMAT % TIMESTAMPS.map do |stamp|
      time["#{prefix[0]}_#{stamp}"].to_s.rjust(2, '0')
    end
  end
end
