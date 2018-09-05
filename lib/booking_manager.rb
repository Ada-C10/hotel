require 'Date'
require_relative 'room'
require_relative 'reservation'

class Booking_Manager
  attr_reader :rooms, :hotel_reservations

  ROOM_NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  ROOM_COST = 200

  def initialize
    @rooms = load_rooms
    @hotel_reservations = []
  end

  def reserve_room(name, room_number, check_in, check_out)
    reserve = { name: name,
      room_number: room_number,
      check_in_date: check_in,
      check_out_date: check_out
    }
    reservation = Reservation.new(reserve)
    @hotel_reservations << reservation
  end

  def get_rooms
    return @rooms
  end

  def list_reservations(date)
    return reservations_on_date = @hotel_reservations.find_all { |reservation| reservation.nights_of_stay == date }
  end

  def self.total_cost_of_stay(reservation)
    return (reservation.nights_of_stay.length * ROOM_COST)
  end

  # def find_room(find_room_number)
  #   return @rooms.find { |room| room.room_number == find_room_number }
  # end

  def load_rooms
    rooms = []
    ROOM_NUMBERS.each do |num|
      room = Room.new(num)
      rooms << room
    end
    return rooms
  end

end
