require 'date'

module Hotel
  class HotelManager
    attr_reader :rooms
    def initialize
      @rooms = Room.all
    end
  end
end
