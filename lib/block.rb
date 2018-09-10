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
    #when i actually reserve a room, it goes into reserved_in_block array? this is an option for
    # refactor.
    @reserved_in_block = []
    if block_rooms.length > 5
      raise StandardError.new "Block is limited to 5 rooms"
    end
  end

  def block_id_generator
    letters = ('A'..'Z').to_a.shuffle[0..1].join
    id = letters + (0..9).to_a.shuffle[0..2].join
    return id
  end

  def is_available_block?(room)
    return false if @reserved_in_block.include?(room)
  end



end
