class Room
attr_reader :room_number, :reservations, :status

ROOM_STATUS = [:VACANT, :OCCUPIED, :BOOKED]

  def initialize (input)
    @room_number = input
    @reservations = []
    @status = :VACANT
  end

end
