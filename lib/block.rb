class Block
  attr_reader :rooms, :start_time, :end_time, :discount
  attr_accessor :block
  #need to write a test for these

  def initialize(attributes)
    @rooms = attributes[:rooms]  #array of rooms
    @start_time = attributes[:start_time]
    @end_time = attributes[:end_time]
    @discount = attributes[:discount]
    @block = attributes[:block] ||= :NA
  end

# I can reserve a room from within a block of rooms
end
