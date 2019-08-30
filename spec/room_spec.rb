require_relative 'spec_helper'

describe 'Room' do
  let (:rooms)  {
    Hotel::Room.all
  }

  it 'instantiates a room object' do
    new_room = Hotel::Room.new(id: 99, cost: 300)
    # binding.pry
    expect(new_room).must_be_kind_of Hotel::Room
  end

  it 'instantiates 20 rooms' do
    # rooms = Hotel::Room.make_rooms
    # binding.pry
    expect(rooms).must_be_kind_of Array
    expect(rooms.length).must_equal 20
 end
end