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

    context 'when required height field is missing' do
      let(:passport_string) do
        "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884\nhcl:#cfa07d byr:1929"
      end

      it { is_expected.to eq(false) }
    end

    context 'when optional country ID field is missing' do
      let(:passport_string) do
        "hcl:#ae17e1 iyr:2013\neyr:2024\necl:brn pid:760753108 byr:1931\nhgt:179cm"
      end

      it { is_expected.to eq(true) }
    end

    context 'when an optional and a required field are both missing' do
      let(:passport_string) do
        "hcl:#cfa07d eyr:2025 pid:166559648\niyr:2011 ecl:brn hgt:59in"
      end

      it { is_expected.to eq(false) }
    end

    # additional given examples
    context 'for known invalid examples' do
      [
        "eyr:1972 cid:100\n hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926",
        "iyr:2019\nhcl:#602927 eyr:1967 hgt:170cm\necl:grn pid:012533040 byr:1946",
        "hcl:dab227 iyr:2012\necl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277",
        "hgt:59cm ecl:zzz\neyr:2038 hcl:74454a iyr:2023\npid:3556412378 byr:2007",
      ].each do |test_string|
        let(:passport_string) { test_string }

        context "given #{test_string}" do
          it { is_expected.to eq(false) }
        end
      end
    end

    context 'for known valid examples' do
      [
        "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980\nhcl:#623a2f",
        "eyr:2029 ecl:blu cid:129 byr:1989\niyr:2014 pid:896056539 hcl:#a97842 hgt:165cm",
        "hcl:#888785\nhgt:164cm byr:2001 iyr:2015 cid:88\npid:545766238 ecl:hzl\neyr:2022",
        'iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719',
      ].each do |test_string|
        let(:passport_string) { test_string }

        context "given #{test_string}" do
          it { is_expected.to eq(true) }
        end
      end
    end
  end

  describe '#count_valid_passport_strings' do
    it 'counts correctly' do
      expect(instance.count_valid_passports).to eq(2)
    end
  end

  describe '#valid_birth_year?' do
    subject(:byr) { instance.valid_birth_year?(str) }

    # byr valid:   2002
    context 'when valid' do
      let(:str) { '2002' }

      it { is_expected.to eq(true) }
    end

    # byr invalid: 2003
    context 'when invalid' do
      let(:str) { '2003' }

      it { is_expected.to eq(false) }
    end
  end

  describe '#valid_height?' do
    subject(:valid_height) { instance.valid_height?(test_str) }

    # hgt valid:   60in
    context 'given a value in the valid range in inches' do
      let(:test_str) { '60in' }

      it { is_expected.to eq(true) }
    end

    # hgt valid:   190cm
    context 'given a value in the valid range in cm' do
      let(:test_str) { '190cm' }

      it { is_expected.to eq(true) }
    end

    # hgt invalid: 190in
    context 'given a value outside the valid range' do
      let(:test_str) { '190in' }

      it { is_expected.to eq(false) }
    end

    # hgt invalid: 190
    context 'given a value without a unit' do
      let(:test_str) { '190' }

      it { is_expected.to eq(false) }
    end
  end

  describe '#valid_hair_color?' do
    subject(:valid_hair_color) { instance.valid_hair_color?(test_str) }

    # hcl valid:   #123abc
    context 'when valid' do
      let(:test_str) { '#123abc' }

      it { is_expected.to eq(true) }
    end

    context 'when invalid' do
      # hcl invalid: #123abz
      context 'given a character out of range' do
        let(:test_str) { '#123abz' }

        it { is_expected.to eq(false) }
      end

      # hcl invalid: 123abc
      context 'when not prefixed with #' do
        let(:test_str) { '123abc' }

        it { is_expected.to eq(false) }
      end
    end
  end

  describe '#valid_eye_color?' do
    subject(:ecl) { instance.valid_eye_color?(str) }

    # ecl valid:   brn
    context 'when valid' do
      let(:str) { 'brn' }

      it { is_expected.to eq(true) }
    end

    # ecl invalid: wat
    context 'when invalid' do
      let(:str) { 'wat' }

      it { is_expected.to eq(false) }
    end
  end

  describe '#valid_passport_id?' do
    subject(:pid) { instance.valid_passport_id?(str) }

    # pid valid:   000000001
    context 'when valid' do
      let(:str) { '000000001' }

      it { is_expected.to eq(true) }
    end

    # pid invalid: 0123456789
    context 'when invalid' do
      let(:str) { '0123456789' }

      it { is_expected.to eq(false) }
    end
  end
end
