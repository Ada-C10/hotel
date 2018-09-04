require 'pry'


module Hotel
  class Room
    attr_reader :room_number, :status
    ROOM_NUMBERS = [*1..20]

    def initialize(room_number, status=:AVAILABLE)
      @room_number = room_number
      @status = status

      unless ROOM_NUMBERS.include?(@room_number)
        raise ArgumentError, "Room number does not exit in the hotel"
      end
    end


  end
end
