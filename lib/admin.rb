# Jacquelyn Cheng - Nodes

# Admin: Manages bookings for the hotel.

module Hotel
  class Admin
    attr_reader :rooms, :reservations

    def initialize(room_count = 20)
      # Creates an array of 20 Room objects, numbered 1-20
      @rooms = []
      room_count.times do |room_num|
        @rooms << Room.new(room_num + 1)
      end
      # Creates an empty hash to which all reservations are added
      @reservations = {}
      @blocks = {}
    end

    # Makes a reservation by 1. finding an available room,
    # 2. updating its availability, 3. creating a new Reservation that has
    # that room, 4. returning that new Reservation
    def make_reservation(arrive, depart)
      checkin_date = Date.parse(arrive)
      checkout_date = Date.parse(depart)
      valid_dates?(checkin_date, checkout_date) # check dates
      room = assign_rooms(1, checkin_date, checkout_date, :BOOKED) # check availability and return available room
      confirmation_num = reservations.length + 1
      new_res = Reservation.new(checkin_date, checkout_date, room, confirmation_num) # create res
      reservations[confirmation_num] = new_res
      return new_res
    end

    def make_block(block, arrive, depart, room_quantity, discount_rate)
      checkin_date = Date.parse(arrive)
      checkout_date = Date.parse(depart)
      valid_dates?(checkin_date, checkout_date) # check dates
      blocked_rooms = assign_rooms(room_quantity, checkin_date, checkout_date, :BLOCKED) # check availability and return available room
      confirmation_num = blocks.length + 1
      new_block = Block.new(block, checkin_date, checkout_date, discount_rate, blocked_rooms, nil, confirmation_num) # create res
      blocks[confirmation_num] = new_block
      return blocked_rooms
    end

    # TODO dependency on Reservation for checkin_date and checkout_date
    def list_reservations(date)
      if reservations.empty?
        return nil
      else
        return reservations.select { |confirmation, reservation|
          date >= reservation.checkin_date && date <= reservation.checkout_date
        }
      end
    end

    # TODO dependency on Room for is_available?
    def list_available_rooms(day)
      return rooms.select { |room| !room.is_available?(day) }
    end

    private # helper methods
      # raises ArgumentError if dates invalid
      def valid_dates?(checkin_date, checkout_date)
        if checkin_date > checkout_date
          raise ArgumentError, "Check-in date must be before check-out date."
        else
          return true
        end
      end

      # returns an array of the requested number of available Rooms (or 1 Room),
      # or raises an error if not enough rooms availble for the dates/quantity requested
      # TODO: dependency on Room for is_available?
      def available_rooms(room_quantity, checkin_date, checkout_date)
        selected_rooms = rooms.select { |room|
          room.is_available?(checkin_date, checkout_date.prev_day)
        }
        if selected_rooms.empty?
          raise RoomAvailabilityError, "No rooms available from #{checkin_date} to #{checkout_date}."
        elsif selected_rooms.length < room_quantity
          raise RoomAvailabilityError, "Only #{room_quantity} rooms available from #{checkin_date} to #{checkout_date}."
        else
          return selected_rooms.first(room_quantity)
        end
      end

      # TODO dependency on Room for change_room_status
      def assign_rooms(room_quantity, checkin_date, checkout_date, room_status)
        selected_rooms = available_rooms(room_quantity, checkin_date, checkout_date)
        selected_rooms.each do |room|
          room.change_room_status(checkin_date, checkout_date.prev_day, room_status)
        end
        if selected_rooms.length == 1
          return selected_rooms.first
        else
          return selected_rooms
        end
      end
  end

  class RoomAvailabilityError < StandardError
  end
end
