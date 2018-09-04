# Jacquelyn Cheng - Nodes

# Room: Keeps track of the availability of hotel rooms.

module Hotel
  class Room
    attr_reader :rooms_in_hotel, :room_num
    @@rooms_in_hotel = 0

    def initialize(room_num)
      @room_num = room_num
      @@rooms_in_hotel += 1
    end


  end
end
