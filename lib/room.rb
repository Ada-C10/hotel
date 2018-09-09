class Room

  attr_reader :room_number, :reservations, :room_block_bookings

  def initialize(room_number)
    @room_number = room_number
    # @reservations = []
    # @room_block_bookings = []
  end
  # 
  # def add_reservations(reservation)
  #   @reservations << reservation
  # end
  #
  # def add_block(block_booking)
  #   @room_block_bookings << block_booking
  # end

end
