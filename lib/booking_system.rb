module Hotel
  class BookingSystem
    attr_accessor :rooms

    def initialize
      @rooms = load_rooms
    end

    def load_rooms
      rooms = []
      i = 1
      20.times do
        rooms <<
        {
          room_num: i,
          status: :AVAILABLE
        }
        i += 1
      end
      return rooms
    end
  end
end
