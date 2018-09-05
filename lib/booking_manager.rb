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

  def reserve_room(input)

    connected_room_number = find_room_number(input[:room_number])

    reserve = { name: input[:name],
      room_number: connected_room_number,
      check_in_date: input[:check_in_date],
      check_out_date: input[:check_out_date]
    }
    reservation = Reservation.new(reserve)
    connect_reservation_to_room(connected_room_number, reservation)
    @hotel_reservations << reservation
  end

  def self.total_cost_of_stay(reservation)
    return (reservation.nights_of_stay.length * ROOM_COST)
  end

  def get_rooms
    return @rooms
  end

  def list_reservations(date)
    return reservations_on_date = @hotel_reservations.find_all { |reservation| reservation.nights_of_stay == date }
  end


  def find_room_number(find_room_number)
    return @rooms.find { |room| room.room_number == find_room_number }
  end

  def connect_reservation_to_room(connected_room_number, reservation)
      connected_room_number.reservations << reservation
  end

  def load_rooms
    rooms = []
    ROOM_NUMBERS.each do |num|
      room = Room.new(num)
      rooms << room
    end
    return rooms
  end

end
