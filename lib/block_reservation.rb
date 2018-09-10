module Hotel
  class BlockReservation
    attr_accessor :block_id, :reservation_id, :room, :start_date, :end_date, :price_per_night

    def initialize(block_id:,  reservation_id:, room:, start_date:, end_date:, price_per_night:)
      @block_id = block_id
      @reservation_id = reservation_id
      @room = room
      @start_date = start_date
      @end_date = end_date
      @price_per_night = price_per_night
    end
  end
end
