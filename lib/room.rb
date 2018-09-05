module Hotel
  class Room

    attr_reader :room_num, :room_reservations

    def initialize(room_num, room_reservations: [])

      unless [*1..20].include?(room_num)
        raise ArgumentError, "Only room numbers from 1 - 20"
      end

      @room_num = room_num
      @room_reservations = room_reservations
    end
  end

end
