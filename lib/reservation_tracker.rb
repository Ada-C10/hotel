require_relative 'reservation'

class ReservationTracker
  attr_reader :reservations

  def initialize(reservations)
    @reservations = reservations
  end

  def list_reservations(date)
    #write code to list reservations by date
  end


end
