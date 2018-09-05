require_relative 'reservation'
module Hotel

  class ReservationTracker
    attr_reader :reservations

    def initialize(reservations)
      @reservations = load_reservations
    end

    def load_reservations
      reservations = []
      return reservations
    end

    def list_reservations(date)
      reservations_by_date = @reservations.find_all do |reservation|
        reservation.date_range.include?(date)
      end
      return reservations_by_date
    end
  end
end
