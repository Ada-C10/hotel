module Hotel
  class Rooms
    def total_rooms_in_hotel
      return total_num = 20
    end

    def all_room_numbers
      return room_numbers = [*1..total_rooms_in_hotel]
    end

    def list_rooms
      rooms = [*"Room #{all_room_numbers.min}".."Room #{all_room_numbers.max}"]

      return rooms
    end
  end
end
