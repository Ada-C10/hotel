require 'time'
require_relative 'reservation'
require_relative 'front_desk'
require_relative 'room'

class Block
  attr_reader :block_start, :block_end, :rate, :block_rooms, :block_ID
  attr_writer :block_ID
  def initialize(block_start, block_end, rate, converted_rooms)
    @block_start = Date.parse(block_start)
    @block_end = Date.parse(block_end)
    @block_rate = rate
    @block_ID = block_id_generator
    @block_rooms = converted_rooms
    if block_rooms.length > 5
      raise StandardError.new "Block is limited to 5 rooms"
    end
  end

  def block_id_generator
    letters = ('A'..'Z').to_a.shuffle[0..1].join
    id = letters + (0..9).to_a.shuffle[0..2].join
    return id
  end

end
