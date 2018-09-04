# Jacquelyn Cheng - Nodes

# Admin: Loads rooms for future bookings by year.

module Hotel
  class Admin
    attr_reader :rooms

    def initialize(room_count = 20)
      # Creates an array of 20 Room objects, numbered 1-20
      @rooms = []
      room_count.times do |room_num|
        @rooms << Room.new(room_num + 1)
      end
    end

  end
end
