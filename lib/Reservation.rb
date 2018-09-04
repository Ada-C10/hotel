require 'date'
class Reservation

  attr_reader :check_in, :check_out, :cost_per_night, :total

  def initialize(room_number, check_in, check_out, cost_per_night=200)
    @check_in = check_in
    @check_out = check_out
    @cost_per_night = cost_per_night
    @room_number = room_number
  end

end
