module HotBook
# The Hotel class is responsible for knowing about rooms and all rooms

  class Hotel
    attr_reader :room_rate, :room_numbers, :rooms

    def initialize(room_rate: 200.0, room_numbers: ROOM_NUMBERS_FILENAME)
      @room_rate = room_rate
      @room_numbers = load_room_numbers(room_numbers) # Array of Strings
      # do i even need room hash? or just room numbers?
      @rooms = load_rooms # array of hashes
      # a "room" Hash ==== {room_number: "String", room_rate: 200.0}
      # if @rooms == nil || @rooms == []
      #   raise StandardError, "Hotel has no rooms (failed to initalize)"
      # end
    end

    def load_room_numbers(filename)
      CSV.open(filename).flat_map{ |line| line.map { |row| row.upcase }}
    end

# refactor with load CSV of rooms in order to truly test
    def find_rate(room_number)
      room_number = room_number.upcase
      room = rooms.find {|room| room[:room_number] == room_number}
      return room[:room_rate]
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
  end

end
