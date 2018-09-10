require_relative 'room_booker'

module BookingLogic
  class Reservation
    attr_reader :room, :check_in, :check_out

    def initialize(room, check_in, check_out)
      check_date_range(check_in, check_out)
      @room = room
      @check_in = check_in
      @check_out = check_out
    end

    def check_date_range(check_in, check_out)
      if check_out <= check_in
        raise StandardError, "Invalid date range provided"
      end
    end

    def reservation_cost
      days_reserved = check_out - check_in
      return days_reserved.to_i * room.cost
    end
  end
end
