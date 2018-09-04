class Room
attr_reader :room_number, :reservations

  def initialize (input)
    @room_number = input
    @reservations = []
  end

end
