require 'time'
require_relative 'reservation'
require_relative 'front_desk'
require_relative 'room'

class Block
  attr_reader :block_start, :block_end, :rate, :number_of_rooms, :block_ID
  attr_writer :block_ID
  def initialize(block_start, block_end, rate, number_of_rooms)
    @block_start = Date.parse(block_start)
    @block_end = Date.parse(block_end)
    @block_rate = rate
    @block_ID = block_id_generator
    @number_of_rooms = number_of_rooms
    if number_of_rooms > 5
      raise StandardError.new "Block is limited to 5 rooms"
    end
  end

  def block_id_generator
    letters = ('A'..'Z').to_a.shuffle[0..1].join
    id = letters + (0..9).to_a.shuffle[0..2].join
    return id
  end
end

  #In front_desk, create a block! gotta make all these rooms unavailable too.
  # Do I make the booker pick all rooms, probably the easier way to go right now, but actually
  # it might end up being harder to do....would have to take in user input or something...
  #   or do I not even have to think about that??? Like if I just take a array of them, that works
  #     logically and someone else can worry about the user interface....
  #  And then there is a seperate method for booking a room from
  # #a block...this will side step the issues of having to beef up the method for booking a regular room
  # # when you book a room from a block, you must have the ID for hte block to continue. Kinda like a
  # #password for a presale or something. The next part would be to keep track of how many rooms are booked from
  # #the block, so if 5 are blocked and they try to do the 6th, there is not anything left for them and this should raise an error.
  #maybe instead of changing the room cost i can have a multipler that is used on the block room reservations
