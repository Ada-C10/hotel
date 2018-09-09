class Reservation
  attr_reader :room_num, :start_time, :end_time, :price

  def initialize(attributes)
    @room_num = attributes[:room_num]
    @start_time = attributes[:start_time]
    @end_time = attributes[:end_time]
    @price = attributes[:price]
  end

  def total_cost
    total_cost = 0
    return total_cost = ((end_time - start_time) * price).round(2)
  end

end
