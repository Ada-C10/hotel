module BookingLogic
  class RoomBooker
    attr_reader :rooms
    attr_accessor :reservations, :blocks

    def initialize
      @rooms = populate_rooms
      @reservations = []
      @blocks = []
    end

    Room = Struct.new(:id, :cost)

    def populate_rooms
      rooms_array = []

      20.times do |id|
        room = Room.new((id + 1), 200)
        rooms_array << room
      end

      return rooms_array
    end

    def list_rooms
      return @rooms
    end

    def find_room_by_id(room_id)
      return rooms.find { |room| room.id = room_id }
    end
  end
end
