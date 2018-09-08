# Optional - for developer use
require "pry"
require "awesome_print"

# TODO:
# replace constant with CSV
# @room_numbers = load_room_numbers (in initialize)
ROOM_NUMBERS = %W(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)

module HotBook
# The Hotel class is responsible for knowing about rooms and all rooms

  class Hotel
    attr_reader :room_rate, :room_numbers, :rooms

    def initialize(room_rate: 200.0, room_numbers: ROOM_NUMBERS)
      @room_rate = room_rate
      @room_numbers = upcase(room_numbers)
      @rooms = load_rooms # array of hashes
      # a "room" Hash ==== {room_number: "String", room_rate: 200.0}
    end

    def upcase(room_numbers)
      return room_numbers.map! { |room_number| room_number.upcase }
    end

    def load_rooms
      new_rooms = []
      room_numbers.each do |room_number|
        a_room = Hash.new
        a_room[:room_number] = room_number
        a_room[:room_rate] = room_rate
        new_rooms << a_room
      end
      return new_rooms
    end

    def find_room_by_number(query)
      raise ArgumentError, "Your query (room number) must be a String, not " \
                           "a #{query.class}" unless query.is_a? String
      query = query.upcase
      raise StandardError, "No room by that number" unless
                            room_numbers.include?(query) # customize this error
      return rooms.find { |room| room[:room_number] == query}
    end
  end

end
