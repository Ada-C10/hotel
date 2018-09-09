require 'pry'
require_relative 'Reservation'
require_relative 'DateRange'

class Room

  attr_reader :room_number, :reservations

  # Refactor note: Might be better to default reservations to an empty array?
  def initialize(room_number, reservations)
    @room_number = room_number.to_i
    if room_number.between?(1,20) == false
      raise ArgumentError, "Room id must be between 1 and 20. Given #{room_number}."
    end
    @reservations = reservations
  end

  # Refactor note: Change arguments to a hash so order doesn't matter
  def find_reservation(room_number_to_find, check_in_to_find, check_out_to_find, cost_per_night_to_find=200)
    # Access reservations
    # Returns true if any reservations match the given reservation
    # To be used as a helper method in Booking for finding a given reservation cost
    # Should this use select to return array with reservation?
    reservation_to_find = @reservations.find do |reservation|
      reservation.room_number == room_number_to_find &&
      reservation.check_in == check_in_to_find &&
      reservation.check_out == check_out_to_find &&
      reservation.cost_per_night == cost_per_night_to_find
    end
    if reservation_to_find == nil
      return false
    else
      return reservation_to_find
    end
  end

  def is_available?(date)
    # This way Booking can ask each room if they have availability
    # Check reservations to see if room is available
    # Access reservations and ask if any of the ranges include the date
    # If so, return false
    # if not, return true
    !@reservations.any? do |reservation|
      date_range = DateRange.new(reservation.check_in, reservation.check_out)
      date_range.date_within_range?(date)
    end
  end
end
