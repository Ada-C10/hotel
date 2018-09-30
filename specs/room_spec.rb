require_relative 'spec_helper'

describe 'Rooms Class' do
  describe 'initialize rooms' do
    it 'is an instance of Room' do
      test_room = Hotel::Room.new(1)
      expect(test_room).must_be_kind_of Hotel::Room
    end
  end
<<<<<<< HEAD

  it 'creates a list of twenty rooms' do
     @all_rooms = Hotel::Room.create_rooms
     expect(@all_rooms.length).must_equal 20
   end

=======
  it 'has a room number' do
    @room = Hotel::Room.new(5)
    expect(@room.room_number).must_equal 5
  end

  # it 'creates a list of twenty rooms' do
  #   @all_rooms = Hotel::Room.create_rooms
  #   expect(@all_rooms.length).must_equal 20
  # end
>>>>>>> 7ad404c6cf9267bef449cee230493c6008ca966b
end
