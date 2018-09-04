class Room

  attr_reader :room_number, :reservations

  def initialize(room_number, reservations)
    @room_number = room_number.to_i
    if room_number.between?(1,20) == false
      raise ArgumentError, "Room id must be between 1 and 20. Given #{room_number}."
    end
    @reservations = reservations
  end
end
