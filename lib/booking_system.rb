require 'date'
require_relative "reservation"
require_relative "date_range"
require_relative "block"
require 'pry'


module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations

    def initialize
      @rooms =
      [
        {room_number: 1}, {room_number: 2}, {room_number: 3}, {room_number: 4}, {room_number: 5}, {room_number: 6}, {room_number: 7}, {room_number: 8}, {room_number: 9}, {room_number: 10}, {room_number: 11}, {room_number: 12}, {room_number: 13}, {room_number: 14}, {room_number: 15}, {room_number: 16}, {room_number: 17}, {room_number: 18}, {room_number: 19}, {room_number: 20}
      ]

      @reservations = [  ]

    end

    # method to make_reservation
    # return if successful return res_id
    def make_reservation(cost_per_night, check_in, check_out)
      available_rooms = list_available_rooms(Hotel::DateRange.new(check_in, check_out))
      if available_rooms.empty?
        raise StandardError, "There's no room in the inn"
      end
      room_number = available_rooms.sample[:room_number]
      reservation = Hotel::Reservation.new(room_number, cost_per_night, check_in, check_out)
      @reservations << reservation
      return reservation
    end

    #make block reservation
    # error if not between 3-5 rooms
    def make_block_reservation(number_of_rooms, cost_per_night, check_in, check_out)
      available_rooms = list_available_rooms(Hotel::DateRange.new(check_in, check_out))
      if available_rooms.length < number_of_rooms
        raise StandardError, "There's no room in the inn"
      end
      block_reservation = []
      number_of_rooms.times do
        room_number = available_rooms.sample[:room_number]
        reservation = Hotel::Reservation.new(room_number, cost_per_night, check_in, check_out)
        @reservations << reservation
        block_reservation << res
      end
      return block_reservation
    end

    # list reservations for a specific date
    def reservations_by_date(date)
      date = Date.parse(date)
      res_by_date = @reservations.select do |res|
        res.date_range.included_in_date_range(date)
      end
      return res_by_date
    end

    # list reservations for a specific date range
    def reservations_by_date_range(date_range)
      res_by_date_range = @reservations.select do |res|
        res.date_range.overlaps?(date_range)
      end
      return res_by_date_range
    end

    # As an administrator, I can view a list of rooms that are not reserved for a given date range
    # reservation date range overlaps with
    def list_available_rooms(date_range)
      conflicting_reservations = reservations_by_date_range(date_range)

      available_rooms = @rooms.reject do |room|
        conflicting_reservations.find do |res|
          res.room_number == room[:room_number]
        end
      end
      return available_rooms
    end


  end
end
