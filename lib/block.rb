class Block
  attr_reader :start_time, :end_time, :rooms
  attr_accessor :block, :discount

  def initialize(attributes)
    @rooms = attributes[:rooms]
    @start_time = attributes[:start_time]
    @end_time = attributes[:end_time]
    @discount = attributes[:discount]
    @block = attributes[:block] ||= :NA
  end

end
