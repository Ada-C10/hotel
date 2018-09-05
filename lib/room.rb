#As an administrator, I can access the list of all of the rooms in the hotel
class Room
  attr_reader :room_id
  attr_accessor :bookings

  def initialize(room_id)
    @room_id = room_id
    @bookings = []
  end

  def add_booking(reservation)
    @bookings << reservation
  end

end
