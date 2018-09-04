require_relative 'reservation'
require_relative 'room'

class ReservationMaker
  attr_reader :reservations, :rooms

  def initialize(reservations, rooms)
    @reservations = reservations
    @rooms = rooms
  end

end
