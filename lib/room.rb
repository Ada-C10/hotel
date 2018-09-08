require_relative 'lib_file_helper'

class Room
  attr_accessor :room_number, :dates_booked

  def initialize(room_number)
    @room_number = room_number.to_i
    # @dates_booked is a collection of date instances in which a specific room instance is booked for
    @dates_booked = []
  end

  # Checking if a specific room instance is booked on a specific date
  def is_available?(formatted_date)

    if @dates_booked.include?(formatted_date)
      return false
    else
      return true
    end
  end

end
