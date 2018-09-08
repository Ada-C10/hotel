# Keeps track of 1 room_
class Room
  attr_reader :room_number

  def initialize(room_number)
    @room_number = room_number
  end

  # def is_room_available(date)
  #   # TODO check list of reservations
  #   return true
  # end
end
# end
