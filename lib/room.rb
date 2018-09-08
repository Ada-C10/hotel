module Hotel
  class Room
    attr_reader :room_number, :reservations, :status

    def initialize(room_number)
      @room_number = room_number
      @reservations = []
    end

  end
end
