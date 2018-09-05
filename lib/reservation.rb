BASE_COST = 200

module Hotel

  class Reservation

    attr_reader :date_range, :room_num, :cost

    def initialize(check_in, check_out, room_num)
      @date_range = DateRange.new(check_in, check_out)
      @room_num = room_num
      @cost = get_cost

      if !@room_num.to_s.match /\d+/
        raise ArgumentError, "Invalid Room Number"
      end
    end

    def get_cost
      return @date_range.get_total_days * BASE_COST
    end

  end
end
