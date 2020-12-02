require_relative '../app/password_philosophy'

RSpec.describe PasswordPhilosophy do
  describe 'count valid passwords' do
    let(:input_filename) { 'spec/fixtures/password_philosophy/test.txt' }

    it 'counts correctly' do
      expect(described_class.new(input_filename).count_valid_passwords).to eq(2)
    end
  end

  describe 'valid?' do
    subject(:valid) { described_class.new.valid?(input_string) }

    context 'for a password with the minimum occurrences of the target letter' do
      let(:input_string) { '1-3 a: abcde' }
      it { is_expected.to eq(true) }
    end

    context 'for a password with the maximum occurrences of the target letter' do
      let(:input_string) { '2-9 c: ccccccccc' }
      it { is_expected.to eq(true) }
    end

    context 'for a password with no occurrences of the target letter' do
      let(:input_string) { '1-3 b: cdefg' }
      it { is_expected.to eq(false) }
    end

    context 'for a password with too many occurrences of the target letter' do
      let(:input_string) { '2-9 c: cccccccccc' }
      it { is_expected.to eq(false) }
    end
  end

  describe 'parse' do
    subject(:rules) { described_class.new.parse(input_string) }

    context 'for rules with all single digits' do
      let(:input_string) { '1-3 a: abcde' }

      it { is_expected.to have_attributes( { min: 1, max: 3, target: 'a', password: 'abcde' }) }
    end

    context 'for a maximum with double digits' do
      let(:input_string) { '1-30 a: abcde' }

      it { is_expected.to have_attributes( { min: 1, max: 30, target: 'a', password: 'abcde' }) }
    end

    context 'for a minimum and maximum with double digits' do
      let(:input_string) { '10-30 a: abcde' }

      it { is_expected.to have_attributes( { min: 10, max: 30, target: 'a', password: 'abcde' }) }
    end
  end
end
