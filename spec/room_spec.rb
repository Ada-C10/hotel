
require_relative 'spec_helper.rb'

describe "initialize" do

# Test to make sure it takes correct parameters
  it 'Takes in a room number and availability status' do
    room_number = 5
    availability = :avaliable
    test_room = Room.new(room_number, availability)

    expect(test_room).must_respond_to :room_number
    expect(test_room.room_number).must_equal room_number

    expect(test_room).must_respond_to :availability
    expect(test_room.availability).must_equal availability
  end

 # Test to make sure that rooms checked are only 1-20
  it 'Raise argument error for invalid room number' do
    expect{Room.new(237, :avaliable)}.must_raise ArgumentError
  end

# initialize end
end
