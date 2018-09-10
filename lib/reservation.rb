module Hotel
  class Reservation
    PRICE_PER_NIGHT = 200.00

    attr_reader :date_range, :room_number

    def initialize(date_range, room_number)
      @date_range = date_range
      @room_number = room_number
    end

    def number_of_nights
      return (@date_range.end_date - @date_range.start_date).to_i
    end

    def total_cost
      return ("%.2f" % (number_of_nights * PRICE_PER_NIGHT)).to_f
    end

  end
end
