module Hotel
  class BlockReservation
    attr_accessor :block_id, :reservation_id, :room, :start_date, :end_date, :discounted_price

    def initialize(block_id:,  reservation_id:, room:, start_date:, end_date:, discounted_price:)
      @block_id = block_id
      @reservation_id = reservation_id
      @room = room
      @start_date = start_date
      @end_date = end_date
      @discounted_price = discounted_price
    end
  end
end
