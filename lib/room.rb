# Keeps track of the availibility of 1 room

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
