class Room
  attr_reader :room_num, :cost, :availability

  def initialize(room_num, cost = 200)
    @room_num = room_num
    @cost = cost
    @availabiity = []
  end
end
