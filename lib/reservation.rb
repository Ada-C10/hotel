require 'time'
require 'date'

module Hotel
  class Reservation
    attr_accessor :room, :check_in, :check_out, :cost

    def initialize(input)
      @room = input[:room]
      @check_in = Date.strptime(input[:check_in], '%m/%d/%Y')
      @check_out = Date.strptime(input[:check_out], '%m/%d/%Y')
      @cost = calculate_cost
    end

    def room_reserved
      return @room
    end

    def calculate_cost
      total_days = (@check_out - @check_in).to_i
      return (total_days * @room.price)
    end

  end
end
