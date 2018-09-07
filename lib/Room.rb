require 'pry'
require_relative 'Reservation'
require_relative 'DateRange'

class Room

  attr_reader :room_number, :reservations

  # Default reservations to an empty array?
  def initialize(room_number, reservations)
    @room_number = room_number.to_i
    if room_number.between?(1,20) == false
      raise ArgumentError, "Room id must be between 1 and 20. Given #{room_number}."
    end
    @reservations = reservations
  end

  # Change arguments to a hash so roder doesn't matter?
  def find_reservation(room_number, check_in, check_out, cost_per_night=200)
    # Access reservations
    # Returns true if any reservations match the given reservation
    # To be used as a helper method in Booking for finding a given reservation cost
    @reservations.any? do |reservation|
      reservation.room_number == room_number &&
      reservation.check_in == check_in &&
      reservation.check_out == check_out &&
      reservation.cost_per_night == cost_per_night
    end
  end

  def is_available?(date)
    # This way Booking can ask each room if they have availability
    # Check reservations to see if room is available
    # Maybe access reservations and ask if any of the ranges include the date
    # If so, return false
    # if not, return true
    !@reservations.any? do |reservation|
      date_range = DateRange.new(reservation.check_in, reservation.check_out)
      date_range.date_within_range?(date)
    end
  end
end
