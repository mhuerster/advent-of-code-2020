require_relative '../app/passport_processing'

RSpec.describe PassportProcessing do
  let(:batch_filename) { 'spec/fixtures/passport_processing/test.txt' }
  let(:instance) { described_class.new(batch_filename) }

  describe('#valid?') do
    subject(:valid) { instance.valid?(passport_string) }

    context 'given all passport fields' do
      let(:passport_string) do
        "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm"
      end

      it { is_expected.to eq(true) }
    end

    context 'missing required height field' do
      let(:passport_string) do
        "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884\nhcl:#cfa07d byr:1929"
      end

      it { is_expected.to eq(false) }
    end

    context 'missing optional country ID field' do
      let(:passport_string) do
        "hcl:#ae17e1 iyr:2013\neyr:2024\necl:brn pid:760753108 byr:1931\nhgt:179cm"
      end

      it { is_expected.to eq(true) }
    end

    context 'missing an optional and a required field' do
      let(:passport_string) do
        "hcl:#cfa07d eyr:2025 pid:166559648\niyr:2011 ecl:brn hgt:59in"
      end

      it { is_expected.to eq(false) }
    end
  end

  describe '#count_valid_passport_strings' do
    it 'counts correctly' do
      expect(instance.count_valid_passports).to eq (2)
    end
  end
end
