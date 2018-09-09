module Hotel
  class Reservation
    attr_accessor :reservation_id, :room, :start_date, :end_date, :price_per_night, :total_cost

    def initialize(reservation_id:, room:, start_date:, end_date:, price_per_night:)
      @reservation_id = reservation_id
      @room = room
      @start_date = start_date
      @end_date = end_date
      @price_per_night = price_per_night
    end
  end
end
