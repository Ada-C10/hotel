require 'date'

require_relative 'reservation'
require_relative 'room'

module Hotel

  class ReservationTracker
    attr_reader :reservations, :rooms, :date_range

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

    def reserve_room(start_date, end_date)
      #write code to reserve room by date
    end
  end
end
