module Hotel
  class BlockRoom
    BLOCK_ROOM_RATE = 100.00
    attr_reader :date_range, :block_rooms

    def initialize(date_range, block_rooms)
      @date_range = date_range
      @block_rooms = block_rooms
    end

    def block_dates_duration
      return (@date_range.end_date - @date_range.start_date).to_i
    end

    def block_cost
      return ("%.2f" % (block_dates_duration * BLOCK_ROOM_RATE)).to_f
    end


  end
end
