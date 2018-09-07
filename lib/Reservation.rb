require 'date'
require 'pry'

require_relative 'Booking'

class Reservation
  # Do instance of room in initialize?
  attr_reader :room_number, :check_in, :check_out, :cost_per_night, :total

  def initialize(room_number, check_in, check_out, cost_per_night=200)

    if check_in.class != Date || check_out.class != Date
      raise ArgumentError, "Please enter a date in mm-dd-yyyy format"
    end

    @room_number = room_number
    @check_in = check_in
    @check_out = check_out
    @cost_per_night = cost_per_night
    @total = reservation_cost
  end

  # # Should this be in date?
  def number_of_days_reserved
    return (check_out - check_in).to_i
  end

  def reservation_cost
    return number_of_days_reserved * cost_per_night
  end


end
