require_relative 'date_logic'
require_relative 'room_booker'

module BookingLogic
  class Reservation
    include DateLogic
    attr_reader :room, :check_in, :check_out

    def initialize(room, check_in, check_out)
      @room = room
      @check_in = check_in
      @check_out = check_out
    end

    def reservation_cost
      days_reserved = check_out - check_in
      return days_reserved.to_i * room.cost
    end
  end
end
