require 'date'
require 'reservation'
require 'pry'
module Hotel

  class Room
    attr_reader :room_number, :cost, :reservation
    def initialize(room_number)
      @room_number = room_number
      @cost = 200
      @reservation = []
      if room_number > 20 || room_number < 1
        raise ArgumentError.new "NOT VALID ROOM NUMBER"
      end
    end
  end
end
