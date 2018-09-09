require 'pry'
require 'awesome_print'

require 'date'
require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class HotelBooker
    attr_reader :rooms, :reservations, :booked_dates
    attr_accessor

    NUM_ROOMS = 20

    def initialize()
      @reservations = []
      @booked_dates = []
      @rooms = []
      NUM_ROOMS.times do |i|
        @rooms << Hotel::Room.new(i+1)
      end
    end

    # arguments for dates are strings
    def make_reservation(id, check_in, check_out)
      check_in = Date.parse(check_in)
      check_out = Date.parse(check_out)
      date_range = Hotel::DateRange.new(check_in, check_out)
      reservation = Hotel::Reservation.new(id, date_range)

      available = unreserved_rooms(check_in, check_out)
      if available == []
        raise StandardError, "There are no more available rooms for this date range!"
      else
        reservation.room = available[0]
      end


      @reservations << reservation
      @booked_dates << date_range.dates_booked
    end

    # arguments must be Dates, not strings
    def unreserved_rooms(check_in, check_out)
      reserved_rooms = []
      new_range = Hotel::DateRange.new(check_in, check_out)

      @reservations.each do |reservation|
        reservation_range =
        if reservation.date_range.overlaps?(new_range)
          reserved_rooms << reservation.room
        end
      end

      unreserved = @rooms - reserved_rooms



      return unreserved

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
      return matching_reservations
    end



    def all_booked_dates()
    end

  end
end
