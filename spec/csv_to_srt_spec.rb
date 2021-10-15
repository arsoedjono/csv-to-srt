# frozen_string_literal: true

require 'fileutils'

describe CsvToSrt do
  describe '#run' do
    subject { described_class.run(options) }

    let(:options) { { file_name: "test/fake.csv" } }
    let(:csv) { "s_hour,s_minute,s_second,s_msecond,e_hour,e_minute,e_second,e_msecond,text_id,text_en\n,,14,44,,,16,5,text indo,text eng" }
    let(:srt) { /0\n00:00:14,440 --> 00:00:16,050\ntext (eng|indo)\n?/ }

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
