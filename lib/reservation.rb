# Keeps track of 1 reservation
require_relative 'room'
require 'date'

class Reservation
  attr_reader :check_in_date, :check_out_date, :room

  def initialize(check_in_date, check_out_date, room)
    @check_in_date = check_in_date
    @check_out_date = check_out_date
    @room = room
    raise StandardError, 'The end date cannot be before the start date.' if check_out_date <= check_in_date
  end

  def booking_range
    return date_range = check_out_date - check_in_date
  end

  def rate
    booking_range * 200
  end
end
