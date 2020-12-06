require_relative '../app/custom_customs'

RSpec.describe CustomCustoms do
  let(:input_filename) { 'spec/fixtures/custom_customs/test.txt' }

  describe '.run' do
    subject(:count) { described_class.run(input_filename) }

    it { is_expected.to eq(6) }
  end
end
