class Room
  attr_reader :room_number, :price_per_night, :reservations

  def initialize(room_number, price_per_night)
    @room_number = room_number
    @price_per_night = price_per_night
    @reservations = []
  end

  def is_available?(date)
    @reservations.each do |reservation|
      return false if reservation.checkin_date <= date && reservation.checkout_date > date
    end
    return true
  end

  def add_reservation(reservation)
    @reservations << reservation
  end



end
