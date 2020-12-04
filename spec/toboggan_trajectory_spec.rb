require_relative '../app/toboggan_trajectory'
require 'pry'

RSpec.describe TobogganTrajectory do
  let(:map_filename) { 'spec/fixtures/toboggan_trajectory/test.txt' }
  let(:instance) { described_class.new(x, y, map_filename) }

  describe 'count_trees' do
    subject { instance.count_trees }

    # Given test cases
    [
      [1, 1, 2],
      [3, 1, 7],
      [5, 1, 3],
      [7, 1, 4],
      [1, 2, 2],
    ].each do |x, y, expected_count|
      context "given right #{x}, down #{y}" do
        let(:x) { x }
        let(:y) { y }

        it { is_expected.to eq(expected_count) }
      end
    end
  end
end
