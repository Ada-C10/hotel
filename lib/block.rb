# Jacquelyn Cheng - Nodes

# Block: Blocks off rooms at a certain rate during an event.

module Hotel
  class Block < BookingDates
    class InvalidBlockError < StandardError
    end

    attr_reader :block_name, :checkin, :checkout, :rooms, :available_rooms, :discount_rate

    DISCOUNT_RATE = 175.00
    MAX_BLOCK = 5

    def initialize(block_name, checkin, checkout, rooms, discount_rate: DISCOUNT_RATE)
      super(checkin, checkout)
      if rooms.length > MAX_BLOCK || rooms.length < 1
        raise InvalidBlockError, "Blocks must contain 1-5 rooms."
      end
      @block_name = block_name
      @rooms = rooms
      @available_rooms = rooms.dup
      @discount_rate = discount_rate
    end

    def reserve_from_block(checkin, checkout)
      validate_block(checkin, checkout)

      room = available_rooms.first
      new_res = Reservation.new(checkin, checkout, room, discount_rate: discount_rate, block: self)

      # update block's available rooms
      available_rooms.delete(room)

      return new_res
    end

    def num_rooms_available
      return available_rooms.length
    end

    def num_rooms_booked
      return rooms.length - num_rooms_available
    end

    private

      def validate_block(checkin, checkout)
        if self.checkin != checkin || self.checkout != checkout
          raise InvalidBlockError, "Dates requested do not match block"
        elsif num_rooms_available < 1
          raise RoomAvailabilityError, "No blocked rooms available for #{block_name}"
        end
      end
  end
end
