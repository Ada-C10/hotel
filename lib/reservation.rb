module Hotel
  class Reservation
    attr_accessor :id, :room_num, :date_start, :date_end, :cost

    def initialize(id, room_num, date_start, date_end, cost=200)
      @id = id
      @room_num = room_num
      @date_start = date_start
      @date_end = date_end
      @cost = cost
    end
  end
end
