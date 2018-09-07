require 'pry'
require 'time'
require 'date'

module Hotel
  class Room
    attr_reader :room_num, :room_reservations

    def initialize
      @room_num = room_num
      @room_reservations = []
    end

    def add_bookings(new_reserv)
      unless reservation.is_a?(Reservation)
        raise ArgumentError
      end

      @room_reservations << new_reserv

      return @room_reservations
    end


  end
end
