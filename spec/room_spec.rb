require_relative 'spec_helper'

describe 'Room' do
  let (:rooms)  {
    Hotel::Room.make_rooms
  }

  it 'instantiates a room object' do
    new_room = Hotel::Room.new(99, [])
    expect(new_room).must_be_kind_of Hotel::Room
  end

  it 'instantiates 20 rooms' do
    # rooms = Hotel::Room.make_rooms
    # binding.pry
    expect(rooms).must_be_kind_of Array
    expect(rooms.length).must_equal 20
 end

  it 'default cost to 200.00' do
    expect(rooms.first.cost).must_be_close_to 200.00
    expect(rooms.last.cost).must_be_close_to 200.00
  end

  it "defaults an empty array for 'booked_dates'" do
    # binding.pry
    expect((rooms.first).booked_dates).must_be_kind_of Array
    expect((rooms.first).booked_dates).must_be_kind_of Array
  end
end