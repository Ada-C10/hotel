module BookingLogic
  class Reservation
    attr_reader :room_id, :check_in, :check_out

    def initialize(room_id, check_in, check_out)
      @room = find_room_by_id(room_id)
      @check_in = check_in
      @check_out = check_out
    end
  end
end
