class Room
  attr_reader :room_number, :reservations, :price_per_night

  def initialize(room_number, price_per_night) #price_per_night should be removed during refactor
    @room_number = room_number
    @reservations = []
    @price_per_night = price_per_night
  end

  def is_available?(date) #move some of the hotel's availability-checking into this method
    @reservations.each do |reservation|
      return false if reservation.checkin_date <= date && reservation.checkout_date > date
    end
    return true
  end

  def add_reservation(reservation)
    @reservations << reservation
  end



end
