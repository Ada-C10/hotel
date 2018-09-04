require_relative 'spec_helper'

describe 'hotel' do
  it 'returns the string "hotel"' do
    result = hotel()
    expect(result).must_equal "hotel"
  end
end
