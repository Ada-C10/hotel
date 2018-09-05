
require_relative 'spec_helper.rb'

describe "#initialize" do
  # Test to make sure it takes correct parameters
  it 'Takes in a room number' do
    room_number = 5
    test_room = Room.new(room_number)

    expect(test_room).must_respond_to :room_number
    expect(test_room.room_number).must_equal room_number

  end

  # Test to make sure that rooms checked are only 1-20
  it 'Raise argument error for invalid room number' do
    expect{Room.new(237)}.must_raise ArgumentError
  end

end
