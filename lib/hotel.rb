# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
# The Hotel class is responsible for knowing about rooms and all rooms

  class Hotel
    require "csv"
    ROOM_NUMBERS_FILENAME = "data/room_numbers.csv"
    attr_reader :room_rate, :room_numbers, :rooms

    def initialize(room_rate: 200.0, room_numbers: ROOM_NUMBERS_FILENAME)
      @room_rate = room_rate
      @room_numbers = load_room_numbers(room_numbers) # Array of Strings
      # do i even need room hash? or just room numbers?
      @rooms = load_rooms # array of hashes
      # a "room" Hash ==== {room_number: "String", room_rate: 200.0}
    end

    def load_room_numbers(filename)
      CSV.open(filename).flat_map{ |line| line.map { |row| row.upcase }}
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

    # def has_this_room?(query)
    #   raise ArgumentError, "Your query (room number) must be a String, not " \
    #                        "a #{query.class}" unless query.is_a? String
    #   query = query.upcase
    #   if room_numbers.include?(query)
    #     return true
    #   else
    #     raise StandardError, "No room by that number"
    #   end
    # end
  end

end
