require 'date'
require 'pry'

class Reservation

  attr_reader :start_date, :end_date, :room

  def initialize (start_date, end_date, room)
    @start_date = start_date
    @end_date = end_date
    @room = room
    @reservation_duration = reservation_duration
    @cost = cost
  end

  def reservation_duration
    duration = @end_date - @start_date
    return duration.to_i
  end

  def cost
    total_cost = @reservation_duration * 200
    return total_cost.to_f
  end

end
