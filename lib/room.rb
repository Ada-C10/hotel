require_relative 'reservation'
require_relative 'booking'

class Room
  attr_reader :room_number, :status

  def initialize(room_number, status)
    @room_number = room_number
    @status = status
  end

end
