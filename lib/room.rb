module Hotel
class Room

  attr_reader :room_number
  attr_accessor :is_available

  ROOM_NUMBERS = (1..20).map {|num| num }

  def initialize
    @room_number = generate_id
    @is_available = true
  end

  def generate_id
    ROOM_NUMBERS.pop()
  end

end
end
