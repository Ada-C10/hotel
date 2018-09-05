
class Reservation
  attr_reader :guest_id, :room_id, :date_range, :cost

  def initialize(guest_id, room_id, date_range)
    @guest_id = guest_id
    @room_id = room_id
    @date_range = date_range
    @cost = calculate_cost
  end

  def calculate_cost
    nights = (date_range[0]..date_range[-1]).count - 1
    nights * 200.00
  end
end
