require 'time'

module Hotel

  class Room
    attr_accessor :room_number
    attr_reader :price

    def initialize(input)
      @room_number = input[:room_number]
      if @room_number < 1 || @room_number > 20
        raise ArgumentError
      end
      @price = input[:price]
      if @price != 200
        raise ArgumentError
      end
    end

  end

end
