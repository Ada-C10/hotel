require 'time'

module Hotel
  class Room
    attr_reader :room_number, :price

    ROOM_NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

    def initialize(input)
      @room_number = input[:room_number]
      if @room_number < 1 || @room_number > 21
        raise ArgumentError
      end
      @price = input[:price]
      if @price != 200
        raise ArgumentError
      end
    end
  end
end
