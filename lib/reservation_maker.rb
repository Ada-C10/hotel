require_relative 'reservation'
require_relative 'room'

class ReservationMaker
  attr_reader :reservations, :rooms

  def initialize(reservations, rooms)
    @reservations = reservations
    @rooms = rooms
  end

  def reserve_room(start_date, end_date)
    #write code to reserve room by date
  end

end
