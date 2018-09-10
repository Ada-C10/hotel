
module Hotel
  class Reservation
    # TODO: change duration to start/end dates

    PRICE_PER_NIGHT = 200.00
    BLOCK_ROOM_DISCOUNT = 0.15 # 15% discounted rate

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

    def block_room_cost
      return (total_cost - (total_cost * BLOCK_ROOM_DISCOUNT))
    end


  end

end

# b = Hotel::Duration.new('2018-09-01', '2018-09-05')
# c = b.total_duration
# ap c
# a = Hotel::Reservation.new(1,c)
# puts a.total_cost
