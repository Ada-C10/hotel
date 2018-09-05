class Room

  attr_reader :room_number, :cost, :reservations

  def initialize(room_number, cost , reservations = [])
    @room_number = room_number
    @cost = cost 
    @reservations = []
  end

  def add_reservations(reservation)
    @reservations << reservation
  end

end
