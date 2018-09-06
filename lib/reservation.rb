BASE_COST = 200

module Hotel

  class Reservation

    attr_reader :date_range, :room, :cost

    def initialize(check_in, check_out, room)
      @date_range = DateRange.new(check_in, check_out)
      @room = room
      @cost = get_cost

      # if !@room.to_s.match /\d+/
      #   raise ArgumentError, "Invalid Room Number"
      # end
    end

    def get_cost
      return @date_range.get_total_days * BASE_COST
    end

  end
end
