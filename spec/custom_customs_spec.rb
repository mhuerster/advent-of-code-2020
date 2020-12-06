require_relative '../app/custom_customs'

RSpec.describe CustomCustoms do
  let(:input_filename) { 'spec/fixtures/custom_customs/test.txt' }

  it 'counts correctly' do
    expect { described_class.run(input_filename).to eq(11) }
  end
end
