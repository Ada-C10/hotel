require_relative 'date_range'
require 'date'


RATE_PER_NIGHT = 200

module Hotel
  class Reservation
    attr_reader :id, :room, :cost, :date_range

    def initialize(input)
      dates = Hotel::DateRange.new(input[:start_date], input[:end_date])

      @id = input[:id]
      @room = input[:room]
      @date_range = dates.get_range
      @cost = calculate_cost
    end

    def calculate_cost
      cost = RATE_PER_NIGHT * @date_range.length
    end
  end
end
