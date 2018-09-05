require_relative 'room_booker'

module BookingLogic
  class Reservation
    attr_reader :room_id, :check_in, :check_out

    def initialize(room, check_in, check_out)
      @room = room
      @check_in = check_in
      @check_out = check_out
    end
  end
end
