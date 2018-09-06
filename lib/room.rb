require 'pry'
require 'time'
require 'date'


class Room
  attr_reader :room_num, :room_reservations
  attr_accessor :status

  def initialize
    @room_num = room_num
    @room_reservations = []
    # @status = status
  end

  def add_bookings(new_reserv)
    unless reservation.is_a?(Reservation)
      raise ArgumentError
    end

    @room_reservations << new_reserv

    return @room_reservations
  end


end
