module Hotel
  class Room
    attr_reader :room_number, :reservations, :status

    ROOM_STATUS = [:VACANT, :OCCUPIED, :BOOKED]

    def initialize(room_number)
      @room_number = room_number
      @reservations = []
      @status = :VACANT
    end

  end
end
