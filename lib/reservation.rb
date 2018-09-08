module Hotel
  class Reservation
    attr_accessor :id, :room, :start_date, :end_date, :price_per_night, :total_cost

    def initialize(id:, room:, start_date:, end_date:, price_per_night:)
      @id = id
      @room = room
      @start_date = start_date
      @end_date = end_date
      @price_per_night = price_per_night
    end
  end
end
