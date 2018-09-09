module Hotel
  class Room
    attr_reader :room_number, :reservations, :room_cost

    def initialize(room_number)
      @room_number = room_number
      @reservations = []
    end

  end
end
