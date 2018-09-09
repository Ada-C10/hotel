class Room
  attr_reader :num_rooms, :array_of_used_rooms, :rate, :rooms

  ROOMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

  RATE = 200

  def initialize
    @rooms = ROOMS
    @rate = RATE
  end

  def find_all_open_rooms(array_of_used_rooms)
    available_rooms = @rooms - array_of_used_rooms
    if available_rooms == []
      raise ArgumentError, "No available rooms"
    else
      return available_rooms
    end
  end

  def find_available_room(array_of_used_rooms)
    available_room = find_all_open_rooms(array_of_used_rooms).first
    return available_room
  end

  def find_block_of_rooms(num_rooms, array_of_used_rooms)
    room_block = []
    num_rooms.times do
      first_available_room = find_available_room(array_of_used_rooms)
      room_block << first_available_room
      array_of_used_rooms << first_available_room
    end
    return room_block
  end
end
