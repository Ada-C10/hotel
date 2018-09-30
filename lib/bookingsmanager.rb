module HotBook
# The BookingsManager class is responsible for:
# holding all reservations and blocks,
# searching through them, and
# making new reservations and blocks.
# It includes support methods for determining availability/conflicts.

  class BookingsManager
    attr_reader :reservations, :hotel, :blocks

    def initialize(hotel) # expects a dependency injection (HotBook::Hotel.new)
      @hotel = hotel
      @reservations = Reservation.from_csv(RESERVATION_DATA_FILENAME)
      @blocks = [] # a list of Blocks
    end

    def new_reservation(daterange, room_number: suggest_room(daterange))
      validate(:daterange, daterange)
      validate(:room_number, room_number)
      room_number = room_number.upcase
      if room_taken?(daterange, room_number)
        raise RoomIsTakenError, "Room is already reserved some time within "\
                                "this daterange"
      elsif room_blocked?(daterange, room_number)
        raise RoomIsBlockedError, "Room is blocked some time within this "\
                                  "daterange"
      end

      room_rate = hotel.find_rate(room_number)

      new_reservation = HotBook::Reservation.new(daterange: daterange,
                                                 room_number: room_number,
                                                 room_rate: room_rate)
      reservations << new_reservation
      return new_reservation
    end

    def new_block(daterange, rooms, discount_rate: 185.0)
      validate(:daterange, daterange)
      validate(:rooms, rooms)
      if rooms.size > 5
        raise ArgumentError, "A Block cannot have more than 5 rooms"
      end
      # Cannot overlap or conflict with existing reservation
      rooms.each do |room_number|
        if room_taken?(daterange, room_number)
          raise RoomIsTakenError, "Room already has reservation during "\
                                  "this daterange"
        elsif room_blocked?(daterange, room_number)
          raise BlockConflictError, "A block already exists on a room during " \
                                    "this daterange"
        end
      end
      new_block = HotBook::Block.new(daterange: daterange,
                                     rooms: rooms,
                                     room_rate: discount_rate) # Default
      blocks << new_block
      return new_block
    end

    def new_block_reservation(block, room_number: block.available.first)
      validate(:block, block)
      # raise error if the block has no available reservations
      if block.available == [] || nil
        raise NoRoomsAvailableError, "This block is fully booked"
      end
      validate(:room_number, room_number)
      room_number = room_number.upcase
      # make sure the room number is part of the block
      unless block.rooms.include?(room_number)
        raise ArgumentError, "Room is not part of the given block"
      end
      # make sure the room is available
      unless block.available.include?(room_number)
        raise RoomIsTakenError, "Room already reserved during this block"
      end
      # Remove this room from its memory array of what's still available:
      block.disable(room_number)
      new_reservation = HotBook::Reservation.new(daterange: block.daterange,
                                                 room_number: room_number,
                                                 room_rate: block.room_rate)
      @reservations << new_reservation
      return new_reservation
    end

# Returns the first room in the array of available rooms
    def suggest_room(daterange)
      validate(:daterange, daterange)
      available = public_avail_rooms(daterange)
      if available == nil || available == []
        raise HotBook::NoRoomsAvailableError, "All rooms are booked " \
          "during this daterange"
      end
      return available.first
    end

# Returns an array of reservations (EXCLUDING checkout day)
    def list_by_nights(date)
      validate(:date, date)
      return reservations.select {|reservation|
                                   reservation.range.include?(date) }
    end

# Returns array of room numbers that are publicly available during a daterange
    def public_avail_rooms(daterange)
      validate(:daterange, daterange)
      a = conflicting_reservations(daterange).map { |reservation|
                                                     reservation.room_number }
      b = conflicting_blocks(daterange).flat_map { |block| block.rooms }
      available_rooms = hotel.room_numbers - a - b
      return available_rooms
    end

# Searches all reservation dateranges for any conflict with given daterange,
# returns true if room number is already part of a reservation
    def room_taken?(daterange, room_number)
      validate(:daterange, daterange)
      validate(:room_number, room_number)
      a = conflicting_reservations(daterange).map { |reservation|
                                                     reservation.room_number }
      return a.include?(room_number)
    end

# Searches all block dateranges for any conflict with given daterange,
# and returns true if room number is already part of a block
    def room_blocked?(daterange, room_number)
      validate(:daterange, daterange)
      validate(:room_number, room_number)
      b = conflicting_blocks(daterange).flat_map { |block| block.rooms }
      return b.include?(room_number)
    end

# Returns an array of reservations with a daterange conflict
    def conflicting_reservations(daterange)
      validate(:daterange, daterange)
      return reservations.select { |reservation|
        reservation.daterange.conflict?(daterange) }
    end

# Returns an array of blocks with a daterange conflict
    def conflicting_blocks(daterange)
      validate(:daterange, daterange)
      return blocks.select { |block| block.conflict?(daterange) }
    end

    private

    def validate(type, var)
      case type
      when :date
        raise ArgumentError, "Invalid date - use Date.parse (expected Date, " \
        "not #{var.class})" unless var.is_a?(Date)
      when :room_number
        raise ArgumentError, "Invalid room number (expected String, " \
        "not #{var.class})" unless var.is_a?(String)
      when :daterange
        raise ArgumentError, "Invalid daterange (expected HotBook::DateRange," \
        " not #{var.class})" unless var.is_a?(HotBook::DateRange)
      when :rooms
        raise ArgumentError, "Invalid rooms (expected Array of " \
        "Strings)" unless var.is_a?(Array) && var.first.is_a?(String)
      when :block
        raise ArgumentError, "Invalid block (expected HotBook::Block, " \
        "not #{var.class})" unless var.is_a?(HotBook::Block)
      end
    end

  end
end
