require_relative 'spec_helper'

describe 'Room' do
  it 'instantiates a room object' do
    new_room = Hotel::Room.new(99, "test")
    expect(new_room).must_be_kind_of Hotel::Room
  end

  it 'instantiates 20 rooms' do
    rooms = Hotel::Room.make_rooms
    # binding.pry
    expect(rooms.length).must_equal 20
  end

  it 'defualts cost to 200.00' do

  end
end