require_relative 'room'

module Hotel
  class RoomsList
    attr_reader :rooms, :add_rooms, :list_rooms
    def initialize
      @rooms = []
    end

    def add_rooms(room)
      @rooms << room
    end

    def list_rooms

      # return @rooms.select { |r| r.room_number }
      
      list = ""
      @rooms.each_with_index do |room, i|
        each_room = "\n#{i + 1}. Room #{room.room_number}"
        list << each_room
      end

      return list
    end

  end
end


room_1 = Hotel::Room.new(1)
room_2 = Hotel::Room.new(2)
room_3 = Hotel::Room.new(3)

a = Hotel::RoomsList.new()

a.add_rooms(room_1)
a.add_rooms(room_2)
a.add_rooms(room_3)

puts a.list_rooms
