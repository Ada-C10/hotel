class Room
attr_reader :room_number, :reservations, :status

ROOM_STATUS = [:VACANT, :OCCUPIED, :BOOKED]
ROOM_NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
@@rooms = []

  def initialize (input)
    @room_number = input
    @reservations = []
    @status = :VACANT
  end

end
