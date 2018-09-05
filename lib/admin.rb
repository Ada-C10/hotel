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

    # Makes a reservation by 1. finding an available room,
    # 2. updating its availability, 3. creating a new Reservation that has
    # that room, 4. returning that new Reservation
    def make_reservation(arrive, depart)
      checkin_date = Date.parse(arrive)
      checkout_date = Date.parse(depart)
      valid_dates?(checkin_date, checkout_date) # check dates
      room = assign_room(checkin_date, checkout_date) # check availability and return available room
      return Reservation.new(checkin_date, checkout_date, room) # create res
    end

    # raises ArgumentError if dates invalid
    def valid_dates?(checkin_date, checkout_date)
      if checkin_date > checkout_date
        raise ArgumentError, "Check-in date must be before check-out date."
      else
        return true
      end
    end

    # raises ArgumentError if dates invalid
    def assign_room(checkin_date, checkout_date)
      available_rooms = rooms.select { |room|
        room.is_available?(checkin_date, checkout_date.prev_day)
      }
      if available_rooms.empty?
        raise NoRoomsAvailableError, "No rooms available from #{checkin_date} to #{checkout_date}."
      else
        return available_rooms.first.reserve(checkin_date, checkout_date.prev_day)
      end
    end

    def list_reservations(date)
      return rooms.select { |room| !room.is_available?(date, date) }
    end

  end

  class NoRoomsAvailableError < StandardError
  end
end
