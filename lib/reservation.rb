require 'pry'
require 'time'
require 'date'


module Hotel
  class Reservation
    attr_reader :id, :room, :date_range, :total_cost

    RATE_PER_NIGHT = 200

    # put it in an input data structure similar to trips

    def initialize(input)

      @id = input[:id]
      @room = input[:room]
      @date_range = DateRange.new(input[:start_date], input[:end_date])
      @total_cost = input[:total_cost]
    end


    def cost_calculator
      duration = @date_range.duration_cal

      total_cost = (duration) * RATE_PER_NIGHT

      return total_cost.round(2)
    end

  end
end
