require "date"
require "pry"

class Reservation

  attr_reader :room_number, :start_date, :end_date

  def initialize(input)
    @room_number = input[:room_number]
    @start_date = Date.parse(input[:start_date])
    @end_date = Date.parse(input[:end_date])
    @@cost = total_cost
    @block = []
  end

  def total_cost
    nights = (end_date - start_date).to_i
    cost = (nights * 200)
    return cost
  end

end
