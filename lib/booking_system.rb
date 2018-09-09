require_relative 'reservation'
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

      reservation = Reservation.new(check_in_date: check_in_date, check_out_date: check_out_date, room_number: room_number)



      # if @reservations.empty?
      #   @reservations << reservation
      #   return reservation
      # elsif @reservations.length >= 1
      #   requested_dates = reservation.date_range
      #   count = requested_dates.length - 1
      #
      #   @reservations.each do |booking|
      #     booked_dates = booking.date_range
      #     while count >= 0
      #       if booked_dates.include?(requested_dates[count])
      #           if booking.room_number == reservation.room_number
      #
      #             unless reservation.room_number == 20
      #               reservation.room_number += 1
      #             end
      #           end
      #       end
      #
      #       count -= 1
      #     end
      #
      #   end
      #
        @reservations << reservation
        return reservation
      # end
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

    # def available_rooms_for_date_range(check_in_date:, check_out_date:)
    #
    #
    #   @reservations
    # end
  end
end

#
# if @reservations.empty?
#   @reservations << reservation
#   return reservation
# elsif @reservations.length >= 1
#   requested_dates = reservation.date_range
#   count = requested_dates.length - 1
#
#   @reservations.each do |booking|
#     booked_dates = booking.date_range
#     while count >= 0
#       if booked_dates.include?(requested_dates[count])
#           if booking.room_number == reservation.room_number
#
#             unless reservation.room_number == 20
#               reservation.room_number += 1
#             end
#           end
#       end
#
#       count -= 1
#     end
#
#   end
#
#   @reservations << reservation
#   return reservation
# end
# end








# def list_reservations_by_date(date)
#   specific_date = Date.parse("#{date}")
#
#   bookings_by_date = []
#   @reservations.each do |booking|
#     dates = booking.date_range
#     if dates.include?(specific_date)
#       bookings_by_date << booking
#     end
#     # binding.pry
#   end
#
#   return bookings_by_date
# end
