require 'date'
require 'pry'

class Reservation

#input is start, end, and room#
#output is instance of this reservation class (a hash with start, end, room#, and cost)

  attr_reader :start_date, :end_date, :room_num

  def initialize (start_date, end_date, room_num)
    @start_date = start_date
    @end_date = end_date
    @room_num = room_num
    @reservation_duration = reservation_duration
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
