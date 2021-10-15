# frozen_string_literal: true

shared_context 'common' do
  let(:csv_path) { 'test/deep/fake.csv' }
  let(:csv_headers) { %w(s_hour s_minute s_second s_msecond e_hour e_minute e_second e_msecond text_id text_en) }
  let(:csv_fields) { [nil, nil, "1", "2", nil, nil, "4", "0", 'halo', 'hello'] }
  let(:csv) { "#{csv_headers.join(',')}\n#{csv_fields.join(',')}" }

  let(:srt) { /1\n00:00:01,020 --> 00:00:04,000\nh(a|el)lo\n?/ }
end
