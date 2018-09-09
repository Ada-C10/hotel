# every reservation has a room and date range
module Hotel
  class Reservation
    attr_reader :room_number, :room_price, :stay_duration

    def initialize(room_number, room_price, stay_duration)
      @room_number = room_number
      @room_price = room_price
      @stay_duration = stay_duration
    end

    def stay_total_cost
      return @room_price * @stay_duration.duration
    end

  end
end
