# Keeps track of 1 reservation
require_relative 'room'
require 'date'

# module Hotel
class Reservation
  attr_reader :check_in_date, :check_out_date, :room_number, :nights_stayed

  def initialize(check_in_date, check_out_date, room_number)
    @check_in_date = check_in_date
    @check_out_date = check_out_date
    @room_number = room_number
    raise StandardError, 'The end date cannot be before the start date.' if check_out_date <= check_in_date
  end

  def nights_stayed
    date_range = check_out_date - check_in_date
    return date_range.to_i
  end
end
# end
