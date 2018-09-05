

class Room
  attr_reader :room_number

  def initialize(room_number)
    @room_number = room_number
    valid_rooms = (1..20).to_a
    if valid_rooms.include?(room_number)
      red_rum = false
    else
      raise ArgumentError.new("Invalid room number")
    end
  end

def self.all

end



#
end
