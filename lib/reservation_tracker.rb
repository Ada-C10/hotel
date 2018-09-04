module Hotel
class ReservationTracker

  attr_reader :reservations

  def initialize

    @reservations = []

  end

  def add_reservation(reservation)

    unless reservation.class == Hotel::Reservation
      raise ArgumentError, "Please input a valid reservation"
    end

    @reservations << reservation
  end
end
end
