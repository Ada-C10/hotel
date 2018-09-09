module Hotel
  class Room
    attr_reader :room_number, :reservations, :room_cost

    COST_OF_STAY = 200.0

    def initialize(room_number)
      @room_number = room_number
      @reservations = []
      @room_cost = COST_OF_STAY
    end

  end
end
