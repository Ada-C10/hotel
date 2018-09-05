require 'date'
module Hotel

  class Room
    attr_reader :room_number
    def initialize(room_number)
      @room_number = room_number
      @cost = 200
      if room_number > 20 || room_number < 1
        raise ArgumentError.new "NOT VALID ROOM NUMBER"
      end
      @reservation = []
    end

    def self.create_rooms
      all_rooms = []
      i = 1
      20.times do
        Room.new(i)
        all_rooms << Room.new(i)
        i += 1
      end
      return all_rooms
    end

    def self.all
      self.create_rooms
    end
#all below needs tests
    def find_room(room_number)
      Rooms.all.find{|room| room.room_number == room_number}
    end
  end
end
