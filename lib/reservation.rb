require 'pry'
require 'date'

class Reservation
  attr_reader :id, :customer_name, :room, :start_date, :end_date

  def initialize(id, customer_name, room, start_date, end_date)
    if start_date >= end_date || start_date < Date.today
      raise ArgumentError
    else
      @id = id
      @customer_name = customer_name
      @room = room
      @start_date = start_date
      @end_date = end_date
    end
  end

  def dates_booked
    result = []
    date_enter = @start_date
    while date_enter < @end_date
      result << date_enter
      date_enter += 1
    end
    return result
  end

  # def cost
  #   calucate the dates of booking
  #   based on the room cost, calculate the total cost
  #
  # end
  #

end
