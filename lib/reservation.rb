# Jacquelyn Cheng - Nodes

# Reservation: Keeps track of a single guest's reservation.

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room

    def initialize(start_date, end_date, room)
      @start_date = start_date
      @end_date = end_date
      @room = room
    end
  end
end
