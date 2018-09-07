require 'time'
require_relative 'reservation'
require_relative 'front_desk'


  class Room

    attr_reader :room_number, :cost, :room_reservations

    def initialize(room_number)
      @room_number = room_number
      @cost = 200
      @room_reservations = []
      if room_number > 20 || room_number < 1
        raise ArgumentError.new "NOT VALID ROOM NUMBER"
      end
    end

    def add_reservation_to_room (reservation)
      @room_reservations << reservation
  end
end
