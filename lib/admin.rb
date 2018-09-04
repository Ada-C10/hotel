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

    def make_reservation(start_date, end_date, num_of_rooms = 1)
      available_rooms = rooms.select { |room|
        room.is_available?(start_date, end_date)
      }
      if available_rooms.length >= num_of_rooms
        available_rooms.first(num_of_rooms).each do |room|
          room.reserve(start_date, end_date)
        end
      end
    end

    def list_reservations(date)
      return rooms.select { |room| !room.is_available?(date) }
    end

  end
end
