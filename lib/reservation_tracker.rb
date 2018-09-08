require 'pry'
require 'date'
require_relative 'room'
require_relative 'reservation'
# Keeps track of the list of reservations
# module Hotel
class ReservationTracker
  attr_reader :rooms, :check_in_date, :check_out_date, :reservations

  ROOM_RATE = 200

  def initialize
    @rooms = create_rooms
    @reservations = []
    # @unreserved_rooms = []
    # @existing_reservations = []


  end

  # creates and accesses the list of all of the rooms in the hotel
  def create_rooms
    rooms = []
    (1..20).each do |room|
      room = Room.new(room)
      rooms << room
    end
    return rooms
  end

  # reserves a room for a given date range and adds the reservation to the list of reservations
  def reserve_a_room(check_in_date, check_out_date)
    room = @rooms.first
    reservation = Reservation.new(check_in_date, check_out_date, room)
    @reservations << reservation
    # @reserved_rooms << room
    return reservation
  end

  # accesses the list of reservations for a specific date
  def list_of_reservations(date)
    return @reservations.find_all { |reservation| reservation.nights_stayed == date }
  end

  # calculates the total cost for a given reservation
  def cost_for_given_reservation(reservation)
    total_cost = reservation.nights_stayed * ROOM_RATE
    return total_cost
  end

  # accesses a list of rooms that are not reserved for a given date range
  def rooms_not_reserved(check_in_date, check_out_date)

  end

end
# end
