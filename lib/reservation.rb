require 'time'
require 'date'

module Hotel
  class Reservation
    attr_accessor :room, :check_in, :check_out, :cost

    def initialize(input)
      @room = input[:room]
      @check_in = Date.strptime(input[:check_in], '%m/%d/%Y')
      @check_out = Date.strptime(input[:check_out], '%m/%d/%Y')
      @cost = input[:cost]
    end

    # def room_reserved
    # return @room
    #  - what is the room associated with this reservation
    #  - return room instance with this reservation
    # end

    def calculate_cost
      # total_days = (@check_out - @check_in).to_i
      # return (total_days * @room.Room.price)
    end

  end
end
