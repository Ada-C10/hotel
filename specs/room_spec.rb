require_relative 'spec_helper'

describe 'Rooms Class' do
  describe 'initialize rooms' do
    it 'is an instance of Room' do
      test_room = Hotel::Room.new(1)
      expect(test_room).must_be_kind_of Hotel::Room
    end
  end

  it 'creates a list of twenty rooms' do
     @all_rooms = Hotel::Room.create_rooms
     expect(@all_rooms.length).must_equal 20
   end

end
