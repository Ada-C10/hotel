module Hotel

  class Reservation

    attr_reader :date_range, :room_num, :cost

    def initialize(date_range, room_num, rate: 200)
      @date_range = date_range
      @room_num = room_num
      @rate = rate # constant for all normal reservations
      @cost = get_cost

      if !@room_num.to_s.match /\d+/ || @room_num > 20 || @room_num < 1
        raise ArgumentError, "Invalid Room Number"
      end
    end

    def get_cost
      return @date_range.get_total_days * @rate
    end

  end
end
