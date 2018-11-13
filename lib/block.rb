module HotBook
  class Block
    attr_reader :available, :rooms, :daterange, :room_rate

    def initialize(daterange:, rooms:, room_rate: 185.0)
      @daterange = daterange
      @rooms = rooms.map! {|room| room.upcase}
      @available = rooms.clone
      @room_rate = room_rate
    end

# Removes a room from @available once it's reserved
    def disable(query)
      room = available.find { |room| room == query } # guaranteed to return 1
      return available.delete(room) # returns value of what it deleted
    end

# Does the block conflict with another block?
# Is this being used??
    def conflict?(other)
      return daterange.conflict?(other)
    end

  end
end
