# Nessary - do not remove
# gems
# libfiles

# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
# HOTEL CLASS KNOWS ABOUT ROOMS
  class Hotel
    attr_reader :room_count, :room_rate, :rooms

    def initialize(room_count: 20, room_rate: 200.0) #{room_count: 20, room_rate: 200.0}
      @room_count = room_count
      @room_rate = room_rate
      @rooms = load_rooms # [{room_number: :1, room_rate: 200.0}]
    end

    def load_rooms
      new_rooms = []
      room_count.times do |i|
        new_room = Hash.new
        new_room[:room_number] = room_numbers[i]
        new_room[:room_rate] = room_rate
        new_rooms << new_room
      end
      return new_rooms
    end

    def room_numbers
      room_numbers = %i(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
      raise ArgumentError, "Wrong number of room numbers" if room_numbers.size != room_count
      return room_numbers
    end
  end

end
