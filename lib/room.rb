require 'time'
require 'date'

class Room
  attr_reader :room_number, :dates_booked
  
  def initialize(room_number)
    @room_number = room_number
    @dates_booked = []
  end

  def is_available?(date)

  end
end
