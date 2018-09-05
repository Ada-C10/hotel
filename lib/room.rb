class Room
  attr_reader :room_num, :cost, :reservations

  def initialize(room_num, cost = 200)
    @room_num = room_num
    @cost = cost
    @reservations = []
  end


end
