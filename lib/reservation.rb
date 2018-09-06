require 'pry'

class Reservation
  attr_reader :room
  attr_reader :check_in
  attr_reader :check_out
  attr_reader :reservation_dates

  def initialize(room, check_in, check_out)
    @room = room
    @check_in = check_in
    @check_out = check_out
    # @reservation_dates = []


    if check_out < check_in
      raise StandardError.new("Check out date is before check in date")
    end
    @reservation_dates = (@check_in...@check_out).to_a
    # binding.pry
    # @reservation_dates = reservation_dates.to_a


  end

  def stay_duration
    stay_duration = (@check_out - @check_in)
    return stay_duration
  end

  def total_charge(stay_duration)
    total_charge = stay_duration * 200
    return total_charge
  end

end
