require_relative '../app/binary_boarding'

RSpec.describe BinaryBoarding do
  describe '#seat_id' do
    subject(:number) { described_class.seat_id(test_string) }

    {
      'FBFBBFFRLR' => 357,
      'BFFFBBFRRR' => 567,
      'FFFBBBFRRR' => 119,
      'BBFFBBFRLL' => 820,
    }.each do |str, expected_seat_id|
      context "given #{str}" do
        let(:test_string) { str }

        it { is_expected.to eq(expected_seat_id) }
      end
    end
  end

  describe '#decode' do
    subject(:number) { described_class.decode(test_string, max) }

    context 'given a row string' do
      let(:max) { described_class::MAX_ROW }

      {
        'FBFBBFF' => 44,
        'BFFFBBF' => 70,
        'FFFBBBF' => 14,
        'BBFFBBF' => 102,
      }.each do |str, expected_row|
        context "given #{str}" do
          let(:test_string) { str }

          it { is_expected.to eq(expected_row) }
        end
      end
    end

    context 'given a column string' do
      let(:max) { described_class::MAX_COLUMN }

      {
        'RLR' => 5,
        'RRR' => 7,
        'RRR' => 7,
        'RLL' => 4,
      }.each do |str, expected_column|
        context "given #{str}" do
          let(:test_string) { str }

          it { is_expected.to eq(expected_column) }
        end
      end

      context 'given RLR' do
        let(:test_string) { 'RLR' }

        it { is_expected.to eq(5) }
      end
      # BFFFBBFRRR: row 70, column 7, seat ID 567.
      # FFFBBBFRRR: row 14, column 7, seat ID 119.
      # BBFFBBFRLL: row 102, column 4, seat ID 820.
    end
  end
end
