require_relative 'DateRange'
require 'pry'
class Booking
  # manages reservations
    # Will have most methods
    # Makes a reservation - Have booking figure it out
  attr_reader :rooms

  def initialize
    # Creating 20 rooms
    @rooms = []
    i = 1
    20.times do
      @rooms << Room.new(i, [])
      i += 1
    end
  end

  def list_all_rooms
    return @rooms
  end

  # Find room helper method
  def find_room(room_number)
    return @rooms.find { |room| room.room_number == room_number }
  end

  # TODO Can reserve a room for a given date range
  def create_reservation(room_number, check_in, check_out)
    return Reservation.new(room_number, check_in, check_out)
  end

  def add_reservation(room_number, check_in, check_out)
    # create reservation
    reservation = create_reservation(room_number, check_in, check_out)
    # find room (method)
    room = find_room(room_number)
    # push reservation into room
    room.reservations << reservation
  end

  # TODO Can access the list of reservations for given date
  ##### NEED HELP IS RETURNING ALL ROOMS #####
  # Did I write my code backwards? Check this...
  def list_reservations_for_date(date)
    @rooms.reject do |room|
      room.is_available?(date)
      # binding.pry
    end
  end

end

  # TODO Can get the total cost for a given reservation

  # TODO Can view a list of rooms that are not reserved for a given date range

  # TODO Can reserve an available room for a given date range
