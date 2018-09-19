# Keeps track of 1 room_
class Room
  attr_reader :room_number
  
    ROOM_RATE = 200

  def initialize(room_number)
    @room_number = room_number
  end

end
