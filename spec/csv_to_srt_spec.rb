# frozen_string_literal: true

require 'fileutils'

describe CsvToSrt do
  include_context 'common'

  describe '#run' do
    subject { described_class.run(options) }

    let(:options) { { path: csv_path } }

    it 'should create SRT file(s)' do
      file = double('file')

      allow(File).to receive(:read) { csv }
      allow(File).to receive(:open).and_yield(file)
      allow(file).to receive(:write).with(srt)

      subject
    end

    describe 'no path' do
      let(:options) { {} }
      let(:error) { SourceCSV::PATH_NOT_PROVIDED_ERROR }

      it { expect { subject }.to raise_error(error) }
    end
  end
end
