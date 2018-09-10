require_relative 'reservation'

module Hotel
  class RoomBlock < Reservation
    attr_reader :block_size, :discount, :rooms

    def initialize(id:, daily_rate: 200, check_in:, check_out:, discount:0, rooms:[])
      super(id: id, daily_rate: daily_rate, check_in: check_in, check_out: check_out, room_num: room_num) # QUESTION: do i need to specify daily_rate???

      unless !rooms.empty?
        raise StandardError, "Room blocks cannot be empty!"
      end

      @discount = discount/100.to_f
      @rooms = rooms # array of ints
      @block_size = rooms.length

      unless @block_size <= 5 && @block_size > 1
        raise StandardError, "Room blocks must hold at least two rooms and at most five. You entered #{block_size} rooms."
      end

    end

    def discounted_rate()
      return @daily_rate * (1-@discount)
    end

    def total_stay_cost_room()
      length_in_days = @check_out - @check_in
      return discounted_rate() * length_in_days
    end

    def total_stay_cost_block()
      return total_stay_cost_room() * @block_size
    end
  end
end


# block = Hotel::RoomBlock.new(
#   id: "2",
#   rooms: [1,2,3],
#   check_in: "2004-7-1",
#   check_out: "2004-7-4")
#
#   p block.daily_rate
