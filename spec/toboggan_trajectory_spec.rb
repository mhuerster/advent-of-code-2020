require_relative '../app/toboggan_trajectory'

RSpec.describe TobogganTrajectory do
  let(:map_filename) { 'spec/fixtures/toboggan_trajectory/test.txt' }
  let(:x) { 3 }
  let(:y) { 1 }
  let(:instance) { described_class.new(x, y, map_filename) }

  describe 'count_trees' do
    subject { instance.count_trees }

    it { is_expected.to eq(7) }
  end
end
