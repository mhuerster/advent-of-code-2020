require_relative '../app/handy_haversacks'

RSpec.describe HandyHaversacks do
  let(:input_filename) { 'spec/fixtures/handy_haversacks/test.txt' }
  let(:inst) { described_class.new(input_filename) }

  describe '#parse_rules' do
    subject(:rules) { inst.parse_rules }

    context 'given test rules' do
      let(:expected_rules) do
        {
          'light red' => { 'bright white' => 1, 'muted yellow' => 2 },
          'dark orange' => { 'bright white' => 3, 'muted yellow' => 4 },
          'bright white' => { 'shiny gold' => 1 },
          'muted yellow' => { 'shiny gold' => 2, 'faded blue' => 9 },
          'shiny gold' => { 'dark olive' => 1, 'vibrant plum' => 2 },
          'dark olive' => { 'faded blue' => 3, 'dotted black' => 4 },
          'vibrant plum' => { 'faded blue' => 5, 'dotted black' => 6 },
          'faded blue' => {},
          'dotted black' => {},
        }
      end

      it { is_expected.to eq(expected_rules) }
    end
  end

  describe '#containers' do
    subject(:containers) { inst.containers(target_color) }

    context 'given shiny gold' do
      let(:target_color) { 'shiny gold' }
      let(:expected_containers) { ['bright white', 'dark orange', 'muted yellow', 'light red'] }

      it { is_expected.to match_array(expected_containers) }
    end
  end

  describe '#contents_count' do
    subject(:contents) { inst.contents_count(target_color) }

    context 'given shiny gold' do
      let(:target_color) { 'shiny gold' }

      it { is_expected.to eq(32) }
    end
  end
end
