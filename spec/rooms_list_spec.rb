require_relative 'spec_helper.rb'

describe "Rooms List Class" do
  describe 'initialize' do
    before do
      room_1 = Hotel::Room.new(1)
      room_2 = Hotel::Room.new(2)
      room_3 = Hotel::Room.new(3)

      @hotel_rooms = Hotel::RoomsList.new()

      @hotel_rooms.add_rooms(room_1)
      @hotel_rooms.add_rooms(room_2)
      @hotel_rooms.add_rooms(room_3)
    end

    it 'Creates an array of rooms' do
      expect(@hotel_rooms.rooms).must_be_instance_of Array
    end

    it 'Adds an instance of a room' do
      expect(@hotel_rooms.rooms[0]).must_be_instance_of Hotel::Room 

    end
  end
end
