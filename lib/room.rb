module Hotel
  class Room
    #stores information about a hotel room
    attr_reader :room_number

    def initialize(input)
      @room_number = input[:room_number]
      if @room_number > 20 || @room_number < 1
        raise ArgumentError.new("Number must be between 1 - 20")
      end
    end
  end
end
