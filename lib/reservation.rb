require 'pry'
require 'time'
require 'date'


module Hotel
  class Reservation
    attr_reader :id, :room, :date_range

    RATE_PER_NIGHT = 200

    def initialize(input)

      @id = input[:id]
      @room = input[:room]
      @date_range = DateRange.new(input[:start_date], input[:end_date])
    end


    def total_cost
      stay_duration = @date_range.duration_cal

      total_cost = (stay_duration) * RATE_PER_NIGHT

      return total_cost.round(2)
    end

  end
end
