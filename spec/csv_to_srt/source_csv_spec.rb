# frozen_string_literal: true

describe SourceCSV do
  subject { described_class.new(file_name) }

  describe 'valid file' do
    let(:file_name) { 'test/deep/fake.csv' }
    let(:content) { { 'headers' => 'val1', 'example' => 'val2'} }
    let(:csv) { "#{content.keys.join(',')}\n#{content.values.join(',')}" }

    before do
      allow(File).to receive(:read) { csv }
    end

    its(:csv) { is_expected.to be_a(CSV::Table) }
    its('csv.headers') { is_expected.to eq(%w(headers example)) }
    its('csv.size') { is_expected.to eq(1) }
    its('csv.first.to_h') { is_expected.to eq({ 'headers' => 'val1', 'example' => 'val2'}) }

    its(:folder) { is_expected.to eq('test/deep') }
    its(:name) { is_expected.to eq('fake') }
  end

  describe 'file not provided' do
    let(:file_name) { nil }
    let(:error) { described_class::PATH_NOT_PROVIDED_ERROR }

    it { expect { subject }.to raise_error(error) }
  end

  describe 'invalid file' do
    let(:file_name) { 'invalid/file.csv' }
    let(:error) { Errno::ENOENT }

    it { expect { subject }.to raise_error(error) }
  end
end
