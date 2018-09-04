require_relative 'room'
require_relative 'reservation'

module Hotel
  class BookingSystem
    attr_accessor :rooms, :reservations
    def initialize()
      @rooms = load_rooms() #<-- array of all rooms
      @reservations = []
    end

    def load_rooms()
      nums = (1..20).to_a
      all_rooms = nums.map { |num| Hotel::Room.new(num)}

      return all_rooms
    end

    def list_all_rooms()
      all_rooms_str = "Here is a list of all rooms: \n"

      @rooms.each do |room|
        all_rooms_str << "- Room #{room.num} \n"
      end

      return all_rooms_str
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def list_reservations_by_date()
    end

  end
end


# booking = Hotel::BookingSystem.new()
#
# puts booking.list_all_rooms
