# frozen_string_literal: true

describe SourceCSV do
  include_context 'common'

  subject { described_class.new(csv_path) }

  describe 'valid file' do
    before do
      allow(File).to receive(:read) { csv }
    end

    its(:csv) { is_expected.to be_a(CSV::Table) }
    its('csv.headers') { is_expected.to eq(csv_headers) }
    its('csv.size') { is_expected.to eq(1) }
    its('csv.first.to_h') { is_expected.to eq(csv_headers.zip(csv_fields).to_h) }

    its(:folder) { is_expected.to eq('test/deep') }
    its(:name) { is_expected.to eq('fake') }
  end

  describe 'file not provided' do
    let(:csv_path) { nil }
    let(:error) { described_class::PATH_NOT_PROVIDED_ERROR }

    it { expect { subject }.to raise_error(error) }
  end

  describe 'invalid file' do
    let(:file_name) { 'invalid/file.csv' }
    let(:error) { Errno::ENOENT }

    it { expect { subject }.to raise_error(error) }
  end
end
