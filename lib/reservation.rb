# Jacquelyn Cheng - Nodes

# Reservation: Keeps track of a single reservation's info.

require_relative 'BookingDates'

module Hotel
  class Reservation < BookingDates
    attr_reader :checkin, :checkout, :room, :rate, :block

    def initialize(checkin, checkout, room, discount_rate: nil, block: nil)
      super(checkin, checkout)
      @room = room
      @rate = discount_rate ||= room.rate
      @block = block
    end

    def total_cost
      return nights * rate
    end
  end
end
