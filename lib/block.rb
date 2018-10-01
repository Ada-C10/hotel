module Hotel
  class BlockOfRooms
    attr_reader :room_numbers, :date_range, :room_rate

    MAX_ROOM_BLOCK = 5

    def initilize(room_rate, date_range, room_numbers)
      unless room_numbers.length <= MAX_ROOM_BLOCK
        raise ArgumentError("Block of Room request denied. Request exceeds maximum of 5 rooms.")
      end

      @room_numbers = room_numbers
      @date_range = date_range
      @room_rate = room_rate
    end

  end
end
