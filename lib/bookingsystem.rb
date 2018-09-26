# Jacquelyn Cheng - Nodes

# BookingSystem: Manages bookings for the hotel.

module Hotel
  class BookingSystem
    attr_reader :rooms

    def initialize
      @rooms = room_factory
    end

    def reserve_room(checkin, checkout, block_name: nil)
      if block_name
        new_res = reserve_from_block(block_name, checkin, checkout)
      else
        room = available_rooms(checkin, checkout, 1).first
        new_res = Reservation.new(checkin, checkout, room)
        room.add_booking(new_res)
      end
      return new_res
    end

    def block_rooms(block_name, checkin, checkout, room_quantity: 5)
      rooms = available_rooms(checkin, checkout, room_quantity).first(room_quantity)
      new_block = Block.new(block_name, checkin, checkout, rooms)
      rooms.each { |room| room.add_booking(new_block) }
      return new_block
    end

    def list_reservations(date)
      return Reservations.all.select do |res|
        res.contains? date
      end
    end

    # default room_quantity is 0 so an admin can see all available rooms
    # without hitting an error, even if no rooms available
    def available_rooms(checkin, checkout, room_quantity: 0)
      avail_rooms = rooms.select do |room|
        room.is_available?(checkin, checkout)
      end
      raise RoomAvailabilityError if avail_rooms.length < room_quantity
      return avail_rooms
    end
  end

  class RoomAvailabilityError < StandardError
  end
end
