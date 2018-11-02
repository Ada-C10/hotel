require 'time'
require 'date'

module Hotel
  class Reservation
    attr_accessor :room, :check_in, :check_out

    def initialize(input)
      @room = input[:room]
      @check_in = Date.strptime(input[:check_in], '%m/%d/%Y')
      @check_out = Date.strptime(input[:check_out], '%m/%d/%Y')
    end

    def room_reserved
      return @room
    end

  end

end
