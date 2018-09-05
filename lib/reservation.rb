RATE_PER_NIGHT = 200

module Hotel
  class Reservation
    attr_reader :id, :room, :start_date, :end_date, :cost

    def initialize(input)
      @id = input[:id]
      @room = input[:room]
      @start_date = input[:start_date]
      @end_date = input[:end_date]
      @cost = calculate_cost

      raise ArgumentError.new("Start date must be before end date") if @end_date < @start_date
    end

    def date_range
      date_range = (@start_date...@end_date)
      return date_range
    end

    def reservation_period
      reservation_period = ((@end_date - 1) - @start_date).to_i
      return reservation_period
    end

    def calculate_cost
      cost = RATE_PER_NIGHT * reservation_period
    end
  end
end
