require_relative 'DateRange'
require 'pry'
######## Refactor Notes ########
# TODO: Refactor so check_in default is a keyword with default of today,
# check_out is a keyword with default of today + 2
# TODO Refactor initialize methods so initialize is in a wrapper method?


class NoRoomsAvailableError < StandardError
end

class NoReservationExistsError < StandardError
end

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

  # Reservation creator, maybe refactor so check_in/check_out have defaults/order does not matter
  def create_reservation(room_number, check_in, check_out)
    return Reservation.new(room_number, check_in, check_out)
  end

  # Maybe have room_number default to first available room for date range?
  # Wave 2 - Room must be available to be reserved
  def add_reservation(room_number, check_in, check_out)
    # list_rooms_available_for_date_range
    # If no rooms available this will return an error
    # If available, do below with room_number set to first available room 
    # create reservation
    reservation = create_reservation(room_number, check_in, check_out)
    # find room based on room number in reservation
    room = find_room(room_number)
    # push reservation into room
    room.reservations << reservation
  end

  # Would it make sense for date to default to today?
  def list_reservations_for_date(date)
    # Access array of rooms
    @rooms.reject do |room|
      # Check if room is available for the date
      room.is_available?(date)
    end
  end

  # Helper method to check if date ranges overlap
  # Depends on order of arguments, maybe refactor as a hash
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

  # Default start date to today/end date to today + 2?
  # Change to keyword arguments or maybe a hash so order doesn't matter
  def list_rooms_available_for_date_range(start_date, end_date)
    # Create daterange helper method to check if ranges overlap
    # It's okay if start_date and the last day of reservation are the same. (Do check_out - 1 for range end)
    # If any of the room's reservations are within the given range, room is not available
    # Select room if all reservations for the room return false for overlap with the given start date end date
    rooms_available = @rooms.select do |room|
     room.reservations.all? { |reservation| date_range_overlap?(start_date, end_date, reservation.check_in, reservation.check_out) == FALSE }
    end
    if rooms_available.empty?
      raise NoRoomsAvailableError, "No rooms are available for this date range"
    else
      return rooms_available
    end
  end

  def total_cost_for_reservation(room_number, start_date, end_date, cost_per_night=200)
    # See if any rooms have the given reservation
    # If so, return the reservation cost
    # This is a bit messy, would like to refactor if there's time
    room_with_reservation = @rooms.select do |room|
      # find_reservation is only returning true/false, need actual reservation
      room.find_reservation(room_number, start_date, end_date, cost_per_night)
    end
    if room_with_reservation.empty?
      # If the reservation can't be found, raise an error
      raise NoReservationExistsError, "Sorry, your reservation is not in our system."
    else
      # if the reservation is found, return the total
      room_with_reservation[0].find_reservation(room_number, start_date, end_date, cost_per_night).total
    end
  end

end

  # TODO Can reserve an available room for a given date range
