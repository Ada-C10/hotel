# Jacquelyn Cheng - Nodes

# Block: Blocks off rooms at a certain rate during an event.

module Hotel
  class Block
    class InvalidBlockError < StandardError
    end

    attr_reader :block_name, :checkin, :checkout, :rooms, :available_rooms, :reservations, :discount

    DISCOUNT_RATE = 175.00
    MAX_BLOCK = 5
    @@all_blocks = []

    def initialize(block_name, checkin, checkout, rooms, discount_rate: DISCOUNT_RATE)
      super(checkin, checkout)
      if rooms.length > MAX_BLOCK || rooms.length < 1
        raise InvalidBlockError, "Blocks must contain 1-5 rooms."
      end
      @block_name = block_name
      @rooms = rooms
      @available_rooms = rooms.dup
      @discount_rate = discount_rate
      @@all_blocks << self
    end

    def self.all
      return @@all_blocks
    end

    def self.find(block_name, checkin, checkout)
      return all.select do |block|
        (block.block_name.casecmp? block_name) && block.checkin == checkin && block.checkout == checkout
      end
    end

    def reserve_from_block(block_name, checkin, checkout)
      block = validate_block(block_name, checkin, checkout)

      room = block.available_rooms.first
      new_res = Reservation.new(checkin, checkout, room, block.discount_rate, block_name)

      # update block's available rooms
      available_rooms -= room

      # remove block from room's bookings and replace with res
      room.remove_booking(block)
      room.add_booking(new_res)

      return new_res
    end

    def num_rooms_available
      return available_rooms.length
    end

    def num_rooms_booked
      return rooms.length - num_rooms_available
    end

    private

      def validate_block(block_name, checkin, checkout)
        block = find(block_name, checkin, checkout)
        if block == nil
          raise InvalidBlockError, "Block not found"
        elsif block.num_rooms_available < 1
          raise InvalidBlockError, "No rooms available"
        else
          return block
        end
      end
  end
end
