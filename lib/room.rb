# not currently in use
# maybe to use in future want to incorporate different cost per different room
class Room
  attr_reader :room_number, :status

  def initialize(room_number, status)
    @room_number = room_number
    @status = status
  end

end
