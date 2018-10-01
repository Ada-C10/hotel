require_relative 'reservation'

module Hotel
  class RoomBlock < Reservation
    attr_reader :block_size, :discount, :rooms, :status

    def initialize(id:, daily_rate: 200, check_in:, check_out:, discount:0, rooms:[], status: :available)
      super(id: id, daily_rate: daily_rate, check_in: check_in, check_out: check_out, room_num: room_num)

      unless !rooms.empty?
        raise StandardError, "Room blocks cannot be empty!"
      end

      @discount = discount/100.to_f
      @rooms = rooms # array of ints
      @status = status
      @block_size = rooms.length

      unless @block_size <= 5 && @block_size > 1
        raise StandardError, "Room blocks must hold at least two rooms and at most five. You entered #{block_size} rooms."
      end
    end

    def show_status()
      rooms_hash = {}
      @rooms.each do |room|
        rooms_hash[room.to_s] = @status
      end
      return rooms_hash
    end

    def discounted_rate()
      return @daily_rate * (1-@discount)
    end

    def total_stay_cost_room()
      return discounted_rate() * nights_reserved
    end

    def total_stay_cost_block()
      return total_stay_cost_room() * @block_size
    end
  end
end
