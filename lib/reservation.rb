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

    def duration
      duration = ((@end_date - 1) - @start_date).to_i
      return duration
    end

    def calculate_cost
      cost = RATE_PER_NIGHT * duration
    end
  end
end
