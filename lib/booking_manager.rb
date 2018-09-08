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
    room = @rooms.first
    return room
  end

  def make_reservation(start_date, end_date)
    room = find_available_room(start_date, end_date)
    reservation = Reservation.new(room, start_date, end_date)
    @reservations << reservation
    return reservation
  end



end
