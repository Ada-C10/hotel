require 'date'
require 'pry'

class Reservation

  #input is start, end, and room#
  #output is instance of this reservation class (a hash with start, end, room#, and cost)

  attr_reader :start_date, :end_date, :available_room

  def initialize (start_date, end_date, available_room)
  #warning: parentheses after method name is interpreted as an argument list, not a decomposed argument???

    @start_date = start_date
    @end_date = end_date
    @available_room = available_room
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
