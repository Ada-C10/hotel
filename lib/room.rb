require 'time'
require 'date'

class Room
  attr_accessor :room_number, :dates_booked

  def initialize(room_number)
    @room_number = room_number.to_i
    # @dates_booked contains date instances
    @dates_booked = []
  end

  def is_available?(formatted_date)

    if @dates_booked.include?(formatted_date)
      return false
    else
      return true
    end
  end

end
