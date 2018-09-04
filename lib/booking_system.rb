require_relative 'room'

module Hotel
  class BookingSystem
    attr_accessor :rooms
    def initialize()
      @rooms = load_rooms() #<-- array of all rooms
    end

    def load_rooms()
      nums = (1..20).to_a
      all_rooms = nums.map { |num| Hotel::Room.new(num)}

      return all_rooms
    end

    def list_all_rooms()

      puts "Here is a list of all rooms: "
      @rooms.each do |room|
        puts room
      end
    end

  end
end


# booking = Hotel::BookingSystem.new()
# rooms_list = booking.load_rooms
#
# puts rooms_list
# puts rooms_list[0].num
