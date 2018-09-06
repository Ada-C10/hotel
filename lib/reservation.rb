require_relative 'date_range'

RATE_PER_NIGHT = 200

module Hotel
  class Reservation
    attr_reader :id, :room, :cost, :date_range

    def initialize(input)
      @id = input[:id]
      @room = input[:room]
      @date_range = Hotel::DateRange.new(input[:start_date], input[:end_date])
      @cost = calculate_cost
    end

    def calculate_cost
      cost = RATE_PER_NIGHT * @date_range.get_reservation_period
    end
  end
end
