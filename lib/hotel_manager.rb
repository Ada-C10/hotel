require_relative 'room'

class Hotel_Manager
  attr_reader :rooms

  def initialize
    @rooms = []
    @reservations = []
    number = 1
    while number <= 20
      room = Room.new(number)
      @rooms << room
      number += 1
    end
  end

  def get_rooms
    return @rooms
  end

  def find_room(find_room_number)
    return @rooms.find { |room| room.room_number == find_room_number }
  end

end
