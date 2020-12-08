require_relative '../app/password_philosophy'

RSpec.describe PasswordPhilosophy do
  describe 'count valid passwords' do
    let(:input_filename) { 'spec/fixtures/password_philosophy/test.txt' }

    it 'counts correctly' do
      expect(described_class.new(input_filename).count_valid_passwords).to eq(1)
    end
  end

  describe 'valid?' do
    subject(:valid) { described_class.new.valid?(input_string) }

    context 'for a password with target letter in the first position' do
      let(:input_string) { '1-3 a: abcde' }

      it { is_expected.to eq(true) }
    end

    context 'for a password with the target letter in the second position' do
      let(:input_string) { '2-9 c: caccccccc' }

      it { is_expected.to eq(true) }
    end

    context 'for a password with no occurrences of the target letter' do
      let(:input_string) { '1-3 b: cdefg' }

      it { is_expected.to eq(false) }
    end

    context 'for a password that includes the target letter in neither given position' do
      let(:input_string) { '1-3 b: cbefg' }

      it { is_expected.to eq(false) }
    end

    context 'for a password with the target letter in both given positions' do
      let(:input_string) { '2-9 c: ccccccccc' }

      it { is_expected.to eq(false) }
    end
  end

  describe 'parse' do
    subject(:rules) { described_class.new.parse(input_string) }

    context 'for rules with all single digits' do
      let(:input_string) { '1-3 a: abcde' }

      it { is_expected.to have_attributes({ pos1: 0, pos2: 2, target: 'a', password: 'abcde' }) }
    end

    context 'for a second position with double digits' do
      let(:input_string) { '1-30 a: abcde' }

      it { is_expected.to have_attributes({ pos1: 0, pos2: 29, target: 'a', password: 'abcde' }) }
    end

    context 'for a first and second position with double digits' do
      let(:input_string) { '10-30 a: abcde' }

      it { is_expected.to have_attributes({ pos1: 9, pos2: 29, target: 'a', password: 'abcde' }) }
    end
  end
end
