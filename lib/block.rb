require 'date'
require 'securerandom'

class Block
  attr_reader :check_in_date, :check_out_date, :id, :block_of_rooms, :rooms

  BLOCKRATE = 100

  def initialize(id, check_in_date, check_out_date, block_of_rooms)
    @id = SecureRandom.uuid
    @check_in_date = check_in_date
    @check_out_date = check_out_date
    @block_of_rooms = block_of_rooms
    @rooms = []
  end

  def valid_block_of_rooms
    if block_of_rooms > 5
      raise ArgumentError, 'Blocks can have up to 5 rooms.'
    end
  end
end
