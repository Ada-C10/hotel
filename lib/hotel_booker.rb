require 'date'
require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class HotelBooker
    attr_accessor :rooms, :reservations, :unreserved_block, :reserved_block
    NUM_ROOMS = 20
    BLOCK_MAX = 5

    def initialize()
      @unreserved_block = []
      @reserved_block = []
      @reservations = []
      @rooms = []

      NUM_ROOMS.times do |i|
        @rooms << Room.new(i+1)
      end
    end

    def available?(available_rooms)
      if available_rooms.empty?
        raise StandardError, "There are no more available rooms for this date range!"
      end
    end

    def range(check_in, check_out)
      DateRange.new(check_in, check_out)
    end

    # arguments for check_in and check_out are Strings
    def make_reservation(id, check_in, check_out)
      check_in = Date.parse(check_in)
      check_out = Date.parse(check_out)
      reservation = Reservation.new(id, range(check_in, check_out))

      available = unreserved_rooms(check_in, check_out)
      available?(available)

      reservation.room = available[0]
      @reservations << reservation
    end


    def make_block(rooms: nil, discount: nil, check_in: nil, check_out: nil)
      check_in = Date.parse(check_in)
      check_out = Date.parse(check_out)
      date_range = range(check_in, check_out)
      available = unreserved_rooms(check_in, check_out)
      if rooms > BLOCK_MAX
        raise StandardError, "Five is the maximum number of rooms in a block."
      elsif available.length < rooms
        raise StandardError, "There are not enough available rooms to create a block."
      end

      rooms.times do |i|
        reservation = Reservation.new("BLOCK ROOM #{i+1}", date_range)
        available[i].cost = discount
        reservation.room = available[i]
        @unreserved_block << reservation
      end

      return @unreserved_block
    end


    def make_block_reservation(id)
      available?(@unreserved_block)
      @reserved_block << @unreserved_block[0]
      @unreserved_block.delete_at(0)
    end


    # arguments for check_in and check_out are Dates
    def unreserved_rooms(check_in, check_out)
      reserved_rooms = []
      unreserved_block_rooms = []
      reserved_block_rooms = []
      new_range = range(check_in, check_out)

      @reservations.each do |reservation|
        if reservation.date_range.overlaps?(new_range)
          reserved_rooms << reservation.room
        end
      end

      @unreserved_block.each do |reservation|
        if reservation.date_range.overlaps?(new_range)
          unreserved_block_rooms << reservation.room
        end
      end

      @reserved_block.each do |reservation|
        if reservation.date_range.overlaps?(new_range)
          reserved_block_rooms << reservation.room
        end
      end

      unreserved = @rooms - reserved_rooms - unreserved_block_rooms - reserved_block_rooms

      return unreserved
    end

    def unreserved_block_rooms
      unreserved_block_rooms =
      @unreserved_block.map { |reservation| reservation.room }
      return unreserved_block_rooms
    end


    def find_reservations(date)
      matching_reservations = []
      date = Date.parse(date)

      @reservations.each do |reservation|
        reservation_dates = reservation.date_range.dates_booked
        if reservation_dates.include?(date)
          matching_reservations << reservation
        end
      end

      @reserved_block.each do |reservation|
        reservation_dates = reservation.date_range.dates_booked
        if reservation_dates.include?(date)
          matching_reservations << reservation
        end
      end

      return matching_reservations
    end

  end
end
