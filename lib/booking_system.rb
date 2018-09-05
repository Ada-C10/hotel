require 'date'

module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations, :availibility

    def initialize
      @rooms =
      [
        {room_number: 1}, {room_number: 2}, {room_number: 3}, {room_number: 4}, {room_number: 5}, {room_number: 6}, {room_number: 7}, {room_number: 8}, {room_number: 9}, {room_number: 10}, {room_number: 11}, {room_number: 12}, {room_number: 13}, {room_number: 14}, {room_number: 15}, {room_number: 16}, {room_number: 17}, {room_number: 18}, {room_number: 19}, {room_number: 20}
      ]

      @reservations = []



      # methods
      # - Check availibility of room
      # - generate a list of availible rooms?
      # - generate a list of booked rooms?
    end
  end
end
