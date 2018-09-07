require 'pry'
class Reservation
  attr_reader :guest_id, :room, :date_range, :cost

  def initialize(input)
    @guest_id = input[:guest_id]
    @room = input[:room]
    @date_range = input[:date_range]
    @cost = calculate_cost
  end

  def calculate_cost
    nights = date_range.count - 1
    nights * 200.00
  end

end
