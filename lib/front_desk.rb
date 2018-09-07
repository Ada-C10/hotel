require_relative 'room'
require_relative 'reservation'


require 'date'
require 'pry'

class FrontDesk
  attr_reader :reservations, :rooms

  def initialize
    @rooms = load_rooms
    @reservations = []

  end

  def load_rooms
    rooms = []
    20.times do |i|
      rooms << Room.new((i + 1))
    end
    return rooms
  end

  def list_all_rooms
    rooms.each do |room|
      room
    end
  end

  def create_reservation(room_number, start_day, end_day)
    new_reservation = Reservation.new(room_number, start_day, end_day)
    reservations << new_reservation
    room = find_room(room_number)
    room.add_reservation_to_room(new_reservation)

  end

  def find_room(room_number)
    return @rooms.find {|room| room.room_number == room_number}
  end

  def find_by_date(date)
      res = []
      @reservations.each do |reservation|
        if reservation.start_day == Date.parse(date)
          res << reservation
      end
    end
    return res
  end


end
