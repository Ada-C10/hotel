require_relative 'spec_helper'
describe 'hotel' do
  it 'prints hotel' do
    result = hotel()
    expect(result).must_equal 'hotel'
  end
end
