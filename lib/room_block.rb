

module Hotel
  class RoomBlock
    attr_reader :reservation_dates, :room_ids

    def initialize(reservation_dates, room_ids, block_id)

      @reservation_dates = reservation_dates
      @room_ids = room_ids
      @block_id = block_id

    end

  end
end
