require_relative 'reservation_creator'
require 'pry'

module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations

    def initialize
      @reservations = []
      @rooms = [*1..20]
    end

    def make_reservation(check_in_date:, check_out_date:)
      # TODO find a room that's available

      room_number = get_available_room(check_in_date: check_in_date, check_out_date: check_out_date)

      reservation = ReservationCreator.new(check_in_date: check_in_date, check_out_date: check_out_date, room_number: room_number)

      # @reservations << reservation

      # return reservation
      if @reservations.length == 0
        @reservations << reservation
        return reservation
      elsif @reservations.length >= 1
        dates = reservation.date_range
        dates.each do |date|
          overlapping_bookings = list_reservations_by_date(date)
          if overlapping_bookings.length == 0
            @reservations << reservation
            return reservation
          elsif overlapping_bookings.length >= 1
            reservation.room_number += overlapping_bookings.length
            if reservation.room_number > 20
              raise ArgumentError, "unable to reserve, rooms all booked"
            end
            
            @reservations << reservation
            return reservation
          end
        end
      end
    end

    def get_available_room(check_in_date:, check_out_date:)
      return @rooms.first
    end

    def list_all_rooms
      return @rooms
    end

    def list_reservations_by_date(date)
      specific_date = Date.parse("#{date}")

      bookings_by_date = []
      @reservations.each do |booking|
        dates = booking.date_range
        if dates.include?(specific_date)
          bookings_by_date << booking
        end
      end

      return bookings_by_date
    end
  end
end
