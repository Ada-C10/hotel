module Hotel
  class Reservation
    attr_accessor :reservation_id, :room, :start_date, :end_date, :price_per_night, :total_cost

    def initialize(reservation_id:, room:, start_date:, end_date:, price_per_night:)
      @system = Hotel::BookingSystem.new
      @reservation_id = reservation_id
      @room = room
      @start_date = start_date
      @end_date = end_date
      @price_per_night = price_per_night
    end
    def total_cost(reservation_id)
      reservation = @system.find_reservation(reservation_id)
      nights = reservation.end_date - reservation.start_date
      total_cost = nights * reservation.price_per_night
      return total_cost.to_f.round(2)
    end
  end
end
