# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook

# a block holds:
  # a list of blocked room numbers (need to be able to add a room to a block later!)
  # available room numbers array (is updated by book.rb code)
  # daterange
  # room rate

  class Block
    require_relative "daterange"
    attr_reader :available, :rooms, :daterange, :room_rate

    def initialize(daterange:, rooms:, room_rate: 185.0)
      @daterange = daterange
      @rooms = rooms.map! {|room| room.upcase}
      @available = rooms.clone
      @room_rate = room_rate
    end

# remove a room from @available once it's reserved
    def disable(query)
      room = available.find { |room| room == query } # guaranteed to return 1
      return available.delete(room) # returns value of what it deleted
    end

    def conflict?(other)
      return daterange.conflict?(other)
    end

  end
end

# def self.from_csv(filename)
#   # a block is a group of 1-5 reservations with the same daterange and unique
#   # room numbers. (eventually, this could scale to >5 unique room numbers.)
#   # parse the list into blocks
#   blocked_reservations = Reservation.from_csv(filename) # returns array of Reservations
#   # parse the
#   # create new Block from groups of reservations
#   # return an array of Blocks
#   Block.new()
# end
