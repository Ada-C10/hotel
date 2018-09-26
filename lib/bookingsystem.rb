# Jacquelyn Cheng - Nodes

# BookingSystem: Manages bookings for the hotel.

module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations, :blocks

    def initialize
      @rooms = Room.room_factory
      @reservations = []
      @blocks = []
    end

    def reserve_room(checkin, checkout = checkin.next_day, block: nil)
      if block
        new_res = block.reserve_from_block(checkin, checkout)
      else
        room = available_rooms(checkin, checkout).first
        new_res = Reservation.new(checkin, checkout, room)
      end
      return add_booking(new_res)
    end

    def block_rooms(block_name, checkin, checkout = checkin.next_day, room_quantity: 5)
      rooms = available_rooms(checkin, checkout, room_quantity: room_quantity).first(room_quantity)
      new_block = Block.new(block_name, checkin, checkout, rooms)
      add_booking(new_block)
      return new_block
    end

    def list_reservations(date)
      return reservations.select { |res| res.contains? date }
    end

    def available_rooms(checkin, checkout = checkin.next_day, room_quantity: 1)
      date_range = BookingDates.new(checkin, checkout)

      booked_rooms = []

      conflicting_blocks = blocks.select { |block| block.overlaps? date_range }
      if !conflicting_blocks.empty?
        booked_rooms = conflicting_blocks.map{ |booking| booking.rooms }.flatten!
      end

      conflicting_res = reservations.select { |res| res.overlaps? date_range }
      if !conflicting_res.empty?
        conflicting_res.each { |res| booked_rooms << res.room }
      end

      avail_rooms = rooms - booked_rooms.uniq
      raise RoomAvailabilityError, "No rooms available" if avail_rooms.length < room_quantity

      return avail_rooms
    end

    private

      def add_booking(booking)
        if booking.respond_to? :total_cost
          reservations << booking
        elsif booking.respond_to? :reserve_from_block
          blocks << booking
        else
          raise ArgumentError, "Not a valid booking"
        end
        return booking
      end
  end
end
