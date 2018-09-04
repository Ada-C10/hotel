require_relative 'room'
require 'date'

class Hotel
  attr_reader :reservations, :rooms

  def initialize(num, reservations = [])
    @rooms = load_rooms(num)
    @reservations = reservations
  end

  def load_rooms(number)
    rooms = []
    number.times do |i|
      rooms << Room.new((i + 1), 200)
    end
    return rooms
  end

  def list_rooms
    rooms.each do |room|
      room
    end
  end

  def reserve_room(number_of_rooms, start_date, end_date)
    rooms << Reservation.new((i + 1), 200)
  end

end
