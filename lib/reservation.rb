require 'pry'

class Reservation
  attr_reader :room
  attr_reader :check_in
  attr_reader :check_out

  def initialize(room, check_in, check_out)
    @room = room
    @check_in = check_in
    @check_out = check_out

    if check_out < check_in
      raise ArgumentError.new("Check out date is before check in date")
    end
  end

  def total_charge
    stay_duration = (@check_out - @check_in)
    total_charge = stay_duration * 200
    return total_charge

  end

end
