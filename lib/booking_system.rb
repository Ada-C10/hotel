require_relative 'reservation_creator'
require 'pry'

module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations, :dates

    def initialize
      @reservations = []
      @rooms = [*1..20]
      @dates = []
    end

    def make_reservation(check_in_date:, check_out_date:)
      # TODO find a room that's available

      room_number = get_available_room(check_in_date: check_in_date, check_out_date: check_out_date)

      reservation = ReservationCreator.new(check_in_date: check_in_date, check_out_date: check_out_date, room_number: room_number)



      # @dates.each do |date_with_room|
      #   date
      #     if reservation.date_range.include?(date) && reservation.room_number == room
      #
      #       reservation.room_number += 1
      #     end
      #     binding.pry
      #   end
      # end


      @reservations << reservation

      return reservation
    end

    def get_available_room(check_in_date:, check_out_date:)
      return @rooms.first
    end

    def list_all_rooms
      return @rooms
    end

    # def add_dates_with_rooms
    #
    #   @reservations.each do |booking|
    #
    #     booking.date_range.each do |date|
    #       date_with_room = {}
    #       # binding.pry
    #
    #       date_with_room[date] = booking.room_number
    #       @dates << date_with_room
    #     end
    #   end
    #
    #   return @dates
    # end

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
