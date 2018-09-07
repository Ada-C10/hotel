require 'pry'
class Reservation
  attr_reader :guest_id, :room, :date_range, :rate, :status

  def initialize(input)
    @guest_id = input[:guest_id]
    @room = input[:room]
    @date_range = input[:date_range]
    @rate = input[:rate] ||= 200.00
    @status = input[:status] ||= :complete
  end

  def stay_cost
    nights = date_range.count - 1
    nights * rate
  end

end
