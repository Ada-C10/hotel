class Room
  attr_reader :room_num, :reserved_dates
  attr_accessor :block

  def initialize(attributes)
    @room_num = attributes[:room_num]
    @reserved_dates = attributes[:reserved_dates]
    @block = attributes[:status] ||= :NA 
  end
end
