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

  def list_reservations_for_date(date)
    # Access array of rooms
    @rooms.reject do |room|
      # Check if room is available for the date
      room.is_available?(date)
    end
  end

  # Helper method to check if date ranges overlap
  def date_range_overlap?(start_date_one, end_date_one, start_date_two, end_date_two)
    # TRUE if dates match
    # if start_date_one == start_date_two && end_date_one == end_date_two
    #   return true
      # TRUE is date ranges overlap in the front
    if start_date_one < end_date_two && start_date_two < end_date_one
        return true
    else
      return false
    end
  end

  def list_rooms_available_for_date_range(start_date, end_date)
    # Create daterange helper method to check if ranges overlap
    # It's okay if start_date and the last day of reservation are the same. (Do check_out - 1 for range end)
    # If any of the room's reservations are within the given range, room is not available
    @rooms.reject do |room|
      room.reservations.each do |reservation|
        # Check if date range given overlaps with reservation range of check_in to (check_out - 1)
        # Method returns true if ranges overlap so reject method is used
        end_date >= reservation.check_in && start_date <= (reservation.check_out - 1) == false
      end
    end
    # Otherwise room is available

  end

end

  # TODO Can get the total cost for a given reservation

  # TODO Can view a list of rooms that are not reserved for a given date range

  # TODO Can reserve an available room for a given date range
