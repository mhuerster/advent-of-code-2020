require_relative '../app/report_repair'

# Input taken from problem:
# In this list, the two entries that sum to 2020 are 1721 and 299.
# Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.

RSpec.describe ReportRepair do
  let(:report_filename) { 'spec/fixtures/report_repair/test.txt' }
  let(:number_of_target_entries) { 2 }
  let(:instance) { described_class.new(report_filename, number_of_target_entries) }

  describe 'entries' do
    subject(:entries) { instance.entries }

    context 'for two target entries' do
      let(:given_entries) { [1721, 299] }

      it { is_expected.to match_array(given_entries) }
    end

    context 'for three target entries' do
      let(:number_of_target_entries) { 3 }
      let(:given_entries) { [979, 366, 675] }

      it { is_expected.to match_array(given_entries) }
    end
  end

  describe 'run' do
    subject(:product) { instance.run }

    context 'for two target entries' do
      let(:given_product) { 514579 }

      it { is_expected.to eq(given_product) }
    end

    context 'for three target entries' do
      let(:number_of_target_entries) { 3 }
      let(:given_product) { 241861950 }

      it { is_expected.to eq(given_product) }
    end
  end
end
