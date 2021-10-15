# frozen_string_literal: true

describe SRT do
  let(:languages) { %i(id en) }

  describe 'class method' do
    let(:headers) { %w(s_hour s_minute s_second s_msecond e_hour e_minute e_second e_msecond text_id text_en) }
    let(:fields) { [nil, nil, 1, 2, nil, nil, 4, 0, 'halo', 'hello'] }
    let(:row) { CSV::Row.new(headers, fields, false) }

    subject { described_class }

    describe '#extract_languages' do
      it { expect(subject.extract_languages(headers)).to eq(languages) }
    end

    describe '#parse_time' do
      it { expect(subject.parse_time(row, :start)).to eq('00:00:01,020') }
      it { expect(subject.parse_time(row, :end)).to eq('00:00:04,000') }
    end
  end

  describe 'instance method' do
    let(:row) do
      {
        index: 1,
        start_time: '00:00:01,020',
        end_time: '00:00:04,000',
        texts: { id: 'halo', en: 'hello' }
      }
    end

    subject { described_class.new(languages) }

    its(:languages) { is_expected.to eq(languages) }
    its(:subtitle) { is_expected.to eq({ id: [], en: [] }) }

    describe '#append' do
      let(:subtitle) do
        {
          id: ["1\n00:00:01,020 --> 00:00:04,000\nhalo\n"],
          en: ["1\n00:00:01,020 --> 00:00:04,000\nhello\n"]
        }
      end

      before do
        subject.append(row)
      end

      its(:subtitle) { is_expected.to eq(subtitle) }
    end

    describe '#to_file!' do
      let(:srt) { /1\n00:00:01,020 --> 00:00:04,000\nh(a|el)lo\n?/ }

      before do
        file = double('file')

        allow(File).to receive(:read) { csv }
        allow(File).to receive(:open).and_yield(file)
        allow(file).to receive(:write).with(srt)

        subject.append(row)
      end

      it { expect { subject.to_file!('path/to', 'file') }.not_to raise_error }
    end
  end
end
