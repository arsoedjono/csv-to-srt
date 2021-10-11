# frozen_string_literal: true

require 'csv'

class SourceCSV
  PATH_NOT_PROVIDED_ERROR = 'Please put the CSV file path as argument!'

  attr_reader :csv, :folder, :name

  def initialize(path)
    raise PATH_NOT_PROVIDED_ERROR unless path

    splitted_path = path.split('/')

    @csv = CSV.parse(File.read(path), headers: true)
    @folder = splitted_path[0...-1].join('/')
    @name = splitted_path[-1].split('.').first
  end
end
