require 'date'
require 'pry'

class Reservation

  attr_reader :start_date, :end_date, :room

  #receives the start_date, end_date, and room info from ReservationMaker
  def initialize (start_date, end_date, room)
    @start_date = start_date
    @end_date = end_date
    @room = room
    # @reservation_duration = reservation_duration
    @cost = cost
  end

  #calculates the duration of the reservation, to be used to calculate cost in the below method
  def reservation_duration
    duration = @end_date - @start_date
    return duration.to_i
  end

  #The below method works when the rooms are all $200 per night.
  def cost
    total_cost = reservation_duration * 200
    return total_cost.to_f
  end

end
