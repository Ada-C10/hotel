require 'pry'
require 'date'

class Reservation
  attr_reader :id, :customer_name, :room_num, :start_date, :end_date, :cost

  def initialize(id, customer_name, start_date, end_date)
    if start_date >= end_date || start_date < Date.today
      raise ArgumentError
    else
      @id = id
      @customer_name = customer_name
      @room_num = ''
      @start_date = start_date
      @end_date = end_date
      @cost = 0
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

end
