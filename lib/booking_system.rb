require_relative 'room.rb'
require_relative 'reservation.rb'
require 'awesome_print'

class BookingSystem
  attr_reader :num_rooms, :rooms, :reservations

  def initialize()
    @num_rooms = 20
    @reservations = []
    @rooms = load_rooms
  end

  def load_rooms
    rooms =[]
    @num_rooms.times { |room| rooms << Room.new(room + 1)}
    return rooms
  end

  # access the list of all of the rooms in the hotel
  def list_all_rooms
    return @rooms
  end

  # reserve a room for a given date range
  def reserve(check_in_date, check_out_date)
    @reservations << Reservation.new(check_in_date, check_out_date)
  end

  # access the list of reservations for a specific date

  # get the total cost for a given reservation
end
