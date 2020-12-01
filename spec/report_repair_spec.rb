require_relative '../app/report_repair'

# Input taken from problem:
# In this list, the two entries that sum to 2020 are 1721 and 299.
# Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.

RSpec.describe ReportRepair do
  let(:report_filename) { 'spec/fixtures/report_repair/test.txt' }
  let(:instance) { described_class.new(report_filename) }
  let(:given_entries) { [1721, 299] }
  let(:given_product) { 514579 }

  describe 'entries' do
    subject(:entries) { instance.entries }

    it { is_expected.to match_array(given_entries) }
  end

  describe 'run' do
    subject(:product) { instance.run }

    context 'with given input' do
      it { is_expected.to eq(given_product) }
    end
  end
end
