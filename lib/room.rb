class Room
  attr_reader :room_number, :reservations

  def initialize(room_number) #price_per_night should be removed during refactor
    @room_number = room_number
    @reservations = []
  end

  def is_available?(start_date, end_date) #move some of the hotel's availability-checking into this method
    @reservations.each do |reservation|
      (start_date..(end_date - 1)).each do |date|
        return false if reservation.checkin_date <= date && reservation.checkout_date > date
      end
    end
    return true
  end


  def add_reservation(reservation)
    @reservations << reservation
  end



end
