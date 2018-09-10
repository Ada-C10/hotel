# Jacquelyn Cheng - Nodes

# Block: Blocks off rooms at a certain rate during an event.

module Hotel
  class Block
    attr_reader :checkin_date, :checkout_date, :block_name, :discount_rate, :blocked_rooms, :reservations

    MAX_BLOCK = 5

    def initialize(checkin_date, checkout_date, block_name, discount_rate)
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      @block_name = block_name
      @discount_rate = discount_rate
      @blocked_rooms = []
      @reservations = []
    end

    # adds a room to the block and updates rooms status to :BLOCKED
    # checkout_date status is not updated since guest leaves in morning
    # raises an ArgumentError if Room not provided or Room is already in block
    # returns updated rooms collection if successful
    def add_room(room)
      raise ArgumentError, "Must provide a Room." unless room.is_a? Room
      unless blocked_rooms.empty?
        room_nums = blocked_rooms.map { |room| room.room_num }
        raise ArgumentError, "Room already in block." if room_nums.include? room.room_num
      end
      blocked_rooms_booked = reservations.sum { |reservation| reservation.rooms.length }
      if (blocked_rooms.length + blocked_rooms_booked) == MAX_BLOCK
        raise ArgumentError, "Maximum number of rooms alredy in block."
      end
      room.change_room_status(checkin_date, :BLOCKED, checkout_date)
      room.change_nightly_rate(checkin_date, discount_rate, checkout_date)
      blocked_rooms << room
      return blocked_rooms
    end

    # adds a reservation to the block and removes room from @blocked_rooms
    # raises an ArgumentError if Reservation not provided or Reservation is already in block
    # returns updated reservations collection if successful
    def add_reservation(reservation)
      raise ArgumentError, "Must provide a Reservation." unless reservation.is_a? Reservation
      unless reservations.empty?
        conf_nums = reservations.map { |res| res.confirmation_number }
        raise ArgumentError, "Reservation already in block." if conf_nums.include? reservation.confirmation_number
      end
      reservation.rooms.each do |room|
        blocked_rooms.delete(room)
      end
      reservations << reservation
      return reservations
    end

    def num_rooms_available
      return blocked_rooms.length
    end
  end
end
