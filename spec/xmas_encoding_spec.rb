require_relative '../app/xmas_encoding'

RSpec.describe XmasEncoding do
  let(:inst) { described_class.new(input_file) }

  describe '#calculate_target' do
    subject(:target) { inst.calculate_target }

    context 'given the sample input file' do
      let(:input_file) { 'spec/fixtures/xmas_encoding/test.txt' }
      let(:inst) { described_class.new(input_file) }

      it { is_expected.to eq(127) }
    end
  end

  describe '#encryption_weakness' do
    subject(:weakness) { inst.encryption_weakness }

    context 'given the sample input file' do
      let(:input_file) { 'spec/fixtures/xmas_encoding/test.txt' }

      it { is_expected.to eq(62) }
    end
  end
end
