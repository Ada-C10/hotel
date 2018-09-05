require_relative 'spec_helper'
require 'pry'

# describe 'hotel' do
#   it 'returns the string "hotel"' do
#     result = hotel()
#     expect(result).must_equal "hotel"
#   end
# end

describe 'booking_system' do
  it 'returns an instance of a BookingSystem' do
    list = BookingSystem.new("10/10/2018", "10/12/2018", 4)
    expect(list).must_be_kind_of BookingSystem
  end
end


describe 'booking_system' do
  it 'the first room instance should equal 1 for room 1' do
    list = BookingSystem.new("10/10/2018", "10/12/2018", 4)
    expect(list.hotel_instances[0].room).must_equal 1
  end
end
