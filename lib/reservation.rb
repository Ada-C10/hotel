

module Hotel
  class Reservation
    attr_reader :room_id, :reservation_dates, :total_cost

    def initialize(reservation_dates, room_id)

      @reservation_dates = reservation_dates
      @room_id = room_id
      @total_cost = reservation_cost(reservation_dates)

    end

    def reservation_cost(reservation_dates)
      nightly_cost = 200
      total_days = (reservation_dates.length).to_i
      total_cost = total_days * nightly_cost
    end

  end
end
