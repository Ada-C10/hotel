# Jacquelyn Cheng - Nodes

# Room: Keeps track of the pricing per room.

module Hotel
  class Room
    attr_reader :room_num, :rate

    ROOM_COUNT = 20
    NIGHTLY_RATE = 200.00

    def initialize(room_num)
      @room_num = room_num
      @rate = NIGHTLY_RATE
    end

    def self.room_factory
      rooms = []
      ROOM_COUNT.times do |room_num|
        rooms << Room.new(room_num + 1)
      end
      return rooms
    end

    def change_rate(new_rate)
      if new_rate < 0 || !(new_rate.respond_to? :*)
        raise ArgumentError, "Rate must be a number greater than 0"
      end
      @rate = new_rate
    end
  end
end
