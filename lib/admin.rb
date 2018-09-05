# Jacquelyn Cheng - Nodes

# Admin: Loads rooms for future bookings by year.

module Hotel
  class Admin
    attr_reader :rooms

    def initialize(room_count = 20)
      # Creates an array of 20 Room objects, numbered 1-20
      @rooms = []
      room_count.times do |room_num|
        @rooms << Room.new(room_num + 1)
      end
    end

    def make_reservation(start_date, end_date)
      available_rooms = rooms.select { |room|
        room.is_available?(start_date, end_date)
      }
      if available_rooms.length >= 1
        available_rooms.first.reserve(start_date, end_date)
      end
    end

    def list_reservations(date)
      return rooms.select { |room| !room.is_available?(date) }
    end

  end
end
