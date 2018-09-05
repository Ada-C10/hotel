#As an administrator, I can access the list of all of the rooms in the hotel
class Room
  attr_reader :room_id
  attr_accessor :bookings

  @@rooms = []

  def initialize(room_id)
    @room_id = room_id
    @bookings = []
    @@rooms << self
  end

  def add_reservation(reservation)
    @bookings << reservation
  end

  def self.list_rooms
    @@rooms
  end

end
# 
#
# 20.times do |index|
#   Room.new(index+1)
# end
#
# puts Room.list_rooms.length
