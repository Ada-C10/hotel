# Keeps track of the availibility of 1 room
VALID_ROOMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

class Room
  attr_reader :room_number, :availibility

  def initialize(room_number, availibility)
    @room_number = room_number

    room_status = [:available, :unavailable]
    if room_status.include? availibility
      @availibility = availibility
    else
      raise ArgumentError, "Not a valid status"
    end
  end
end
