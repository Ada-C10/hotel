class Room
  attr_reader :room_number, :price_per_night, :reservations

  def initialize(room_number, price_per_night)
    @room_number = room_number
    @price_per_night = price_per_night
    @reservations = []
  end

  def is_available?(date)
  end

  def add_reservation(reservation)
    @reservations << reservation
  end

  

end
