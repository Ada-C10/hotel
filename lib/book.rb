# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
# The Book class is responsible for:
# holding all reservations and blocks,
# searching through them, and
# making new reservations and blocks.
# It includes support methods for determining availability.

TEST_RESERVATION_FILENAME = "support/test_reservation_data.csv"
# RESERVATION_DATA_FILENAME = "data/reservation_data.csv"

  class Book
    require_relative "hotel.rb"
    require_relative "reservation.rb"
    require_relative "block.rb"
    require_relative "errors.rb"
    require "date"
    attr_reader :reservations, :hotel, :blocks

    def initialize(hotel) # expects a dependency injection (HotBook::Hotel.new)
                          # but what if hotel changes? it only updates @ initialize time...
                          # then it needs to change to be treated like Reservation class
                          # luckily, it's already in a class of its own, so it's ready
                          # to do that (rather than hotel having methods for loading etc.)
      @hotel = hotel
      @reservations = Reservation.from_csv(TEST_RESERVATION_FILENAME)
      @blocks = [] # a list of Blocks
    end

    def new_reservation(daterange, room_number: suggest_room(daterange))
      validate(:daterange, daterange)
      validate(:room_number, room_number)
      room_number = room_number.upcase
      if room_taken?(daterange, room_number)
        raise RoomIsTakenError, "Room is already reserved some time within this daterange"
      elsif room_blocked?(daterange, room_number)
        raise RoomIsBlockedError, "This room conflicts with a Block during this daterange"
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
      rooms.each do |room_number|
        if room_taken?(daterange, room_number)
          raise RoomIsTakenError, "Room already has reservation during this daterange"
        end
      end
      new_block = HotBook::Block.new(daterange: daterange,
                                     rooms: rooms,
                                     room_rate: discount_rate) # Default discount
      blocks << new_block
      return new_block
    end

    def new_block_reservation(block, room_number: block.available.first)
      validate(:room_number, room_number)
      validate(:block, block)
      room_number = room_number.upcase
      # make sure the room number is part of the block
      unless block.rooms.include? room_number
        raise StandardError, "Room is not part of the given block"
      end
      unless block.available.include? room_number
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

    def suggest_room(daterange)
      validate(:daterange, daterange)
      return public_avail_rooms(daterange).first
    end

# Returns an array of reservations (EXCLUDING checkout day)
    def list_by_nights(date)
      validate(:date, date)
      return reservations.select {|reservation| reservation.range.include? date}
    end

# Returns an array of room numbers that are publicly available during a daterange
    def public_avail_rooms(daterange)
      validate(:daterange, daterange)
      a = conflicting_reservations(daterange).map { |reservation| reservation.room_number }
      b = conflicting_blocks(daterange).flat_map { |block| block.rooms }
      available_rooms = hotel.room_numbers - a - b
      return available_rooms
    end

# Searches all reservation dateranges for any conflict with given daterange,
# returns true if room number is already part of a reservation
    def room_taken?(daterange, room_number)
      validate(:daterange, daterange)
      validate(:room_number, room_number)
      a = conflicting_reservations(daterange).map { |reservation| reservation.room_number }
      return a.include? room_number
    end

# Searches all block dateranges for any conflict with given daterange,
# and returns true if room number is already part of a block
    def room_blocked?(daterange, room_number)
      validate(:daterange, daterange)
      validate(:room_number, room_number)
      b = conflicting_blocks(daterange).flat_map { |block| block.rooms }
      return b.include? room_number
    end

# Returns an array of reservations with a daterange conflict
    def conflicting_reservations(daterange)
      validate(:daterange, daterange)
      return reservations.select { |reservation| reservation.daterange.conflict?(daterange) }
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
        raise ArgumentError, "Invalid daterange (expected HotBook::DateRange, " \
        "not #{var.class})" unless var.is_a?(HotBook::DateRange)
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



    # def load_reservations(filename)
    #   reservations = CSV.open(filename).map { |row|
    #     start_date = row[0]
    #     end_date = row[1]
    #     room_number = row[2]
    #     room_rate = row[3].to_f
    #     notes = row[4]
    #
    #     HotBook::Reservation.new(
    #       daterange: HotBook::DateRange.new(start_date: start_date,
    #                                         end_date: end_date),
    #       room_number: room_number, room_rate: room_rate, notes: notes)
    #   }
    #   return reservations
    # end

    # def save_reservations(filename)
    # end
