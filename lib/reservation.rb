BASE_COST = 200

module Hotel

  class Reservation

    def initialize(start_date, end_date, room_num)
      @date_range = DateRange.new(start_date, end_date)
      @room_num = room_num
    end

    def get_cost
      return @date_range.get_total_days * BASE_COST
    end

  end
end
