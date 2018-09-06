class Room

  attr_reader :room_number, :cost, :reservations, :block_reservations

  def initialize(room_number, cost )
    @room_number = room_number
    @cost = cost 
    @reservations = []
    @block_reservations = []
  end

  def add_reservations(reservation)
    @reservations << reservation
  end

  def add_block_reservations(block_reservation)
    @block_reservations << block_reservation
  end



end
