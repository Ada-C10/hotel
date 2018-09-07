require 'pry'
require 'date'
require_relative 'room'
require_relative 'reservation'
# Keeps track of the list of reservations
# module Hotel
class ReservationTracker
  attr_reader :rooms, :check_in_date, :check_out_date

  def initialize
    @rooms = create_rooms
    # @reservations = []
    # @existing_reservations = []
    # @unreserved_rooms = []

  end
  # to create and access the list of all of the rooms in the hotel
  def create_rooms
    rooms = []
    (1..20).each do |room|
      room = Room.new(room)
      rooms << room
    end
    return rooms
  end

  # reserve a room for a given date range
  def reserve_a_room(check_in_date, check_out_date)
    room = @rooms.first
    reservation = Reservation.new(check_in_date, check_out_date, room)
  end

  # def list_of_reservations
  # end

end
# end
