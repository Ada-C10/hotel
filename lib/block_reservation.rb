require 'date'
require 'admin'
require 'reservation'

class BlockReservation < Reservation
  attr_reader :id, :room, :start_date, :end_date, :rooms_available, :reservations

  def initialize(id, room, start_date, end_date, rooms_available: [], reservations: [])
    super(id, room, start_date, end_date)

    @rooms_available  = rooms_available
    @reservations = reservations
  end
end
