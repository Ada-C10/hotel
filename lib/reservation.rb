module Hotel

  class Reservation

    def initialize(start_date, end_date, room_num)
      @date_range = DateRange.new(start_date, end_date)
      @room_num = room_num
    end

  end

end
