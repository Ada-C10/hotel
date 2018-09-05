class Calendar
  attr_reader :reservations
  ROOMS = [*1..20]
  def initialize
    @reservations = []
  end
  def add_reservation(reservation)
    @reservations << reservation
  end
end
