require_relative 'no_rooms_in_block'

module BookingLogic
  class RoomBlock
    attr_reader :name, :check_in, :check_out, :rooms, :rate

    def initialize(name, check_in, check_out, room_block, rate)
      check_number_of_rooms(room_block)
      @name = name
      @check_in = check_in
      @check_out = check_out
      @rooms = room_block
      @rate = rate
    end

    def check_number_of_rooms(room_block)
      if room_block.length > 5
        raise StandardError, "Maximum of 5 rooms per room block"
      end
    end

    def available
      available_rooms = rooms.find_all { |room| room.block_reserved == nil }

      if available_rooms.empty?
        raise NoRoomsInBlock, "No rooms currently available in this block"
      else
        return available_rooms
      end
    end

    def set_blocked_room_rate
      rooms.each do |room|
        room.cost = rate
      end
    end
  end
end
