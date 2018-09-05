require_relative 'room'
require_relative 'reservation'
require 'date'

class Admin
  attr_reader :rooms, :reservations

  def initialize
    @rooms = Array.new(20)
      @rooms.length.times do |x|
        room_number = x + 1
        @rooms[x] = Room.new(room_number, :available)
      end
    @reservations = []
  end

  def add_reservation(reservation)
    @reservations << reservation
  end

  def request_reservation(start_date, end_date)
    new = Reservation.new(1, start_date, end_date)

    add_reservation(new)
  end
  #param - date
  #returns - array of reservations within that date
  def reservations_by_date(date)
    @reservations.find_all do |reservation|
      (reservation.start_date..reservation.end_date).cover?(date)
    end
  end

  def select_room
    @rooms.find { |room| room.status == :available }
  end
end
