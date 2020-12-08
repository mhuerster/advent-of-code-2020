require_relative '../app/handheld_halting'

RSpec.describe HandheldHalting do
  let(:input_filename) { 'spec/fixtures/handheld_halting/test.txt' }
  let(:inst) { described_class.new(input_filename) }

  describe '#execute_instructions' do
    subject(:acc) { inst.execute_instructions }

    context 'for the given input file' do
      it { is_expected.to eq(5) }
    end
  end
end
