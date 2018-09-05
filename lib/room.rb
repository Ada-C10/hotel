class Room
  attr_reader :room_num, :cost, :dates_booked

  def initialize(room_num, cost = 200)
    @room_num = room_num
    @cost = cost
    @dates_booked = []
  end

end
