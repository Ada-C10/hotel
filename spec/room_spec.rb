
require_relative 'spec_helper.rb'

describe "#initialize" do
  # Test to make sure it takes correct parameters
  it 'Takes in a room number and availability status' do
    room_number = 5
    availability = :available
    test_room = Room.new(room_number, availability)

    expect(test_room).must_respond_to :room_number
    expect(test_room.room_number).must_equal room_number

    expect(test_room).must_respond_to :availability
    expect(test_room.availability).must_equal availability
  end

  # Test to make sure that rooms checked are only 1-20
  it 'Raise argument error for invalid room number' do
    expect{Room.new(237, :available)}.must_raise ArgumentError
  end

  # Test to make sure status is valid
  it 'Raise argument error for invalid status' do
    expect{Room.new(2, :haunted)}.must_raise ArgumentError
  end
end

describe "#is_available?" do
  # test to make sure it returns true if status is avaliable
  it 'Returns true if status is set to available' do
    room_number = 5
    status = :available
    test_room = Room.new(room_number, status)
    expected = true
    expect(test_room.is_available?).must_equal expected
  end
end
