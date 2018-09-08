require_relative 'reservation.rb'
require 'pry'

class BookingManager

  attr_reader :rooms
  attr_reader :reservations

  def initialize
    @reservations = []
    @rooms = []
    i = 0
    20.times do |i|
      @rooms << i + 1
      i += 1
    end
  end

  def find_available_room(start_date, end_date)
    requested_dates = (start_date...end_date).to_a
    if @reservations.empty?
      return rooms.first
    end
    # use some boolean logic and intersection to call out errors for conflit
    room_count = 1
    while room_count < 20
      @reservations.each_with_index do |reservation, index|
        if reservation.room == (index + 1)
          if (reservation.reservation_dates & requested_dates).length > 0
            room_count += 1
          else
            room = index + 1
            return room
          end
        end
      end
    end
     # raise StandardError.new("No room available")
  end

  def make_reservation(start_date, end_date)
    room = find_available_room(start_date, end_date)
    reservation = Reservation.new(room, start_date, end_date)
    @reservations << reservation
    return reservation
  end
end
