require 'reservation'

class BlockReservation < Reservation
  attr_reader :rooms_available, :reservations

  def initialize(id, room, start_date, end_date, reservations: [])
    super(id, room, start_date, end_date)

    @rooms_available = room.dup
    @reservations = reservations
    @room_cost = 150
  end
end
