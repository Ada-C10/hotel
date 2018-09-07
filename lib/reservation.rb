require_relative 'date_range'

RATE = 200

module Hotel
  class Reservation
    attr_reader :id, :room, :cost, :dates, :date_range

    def initialize(input)
      dates = DateRange.new(input[:start_date], input[:end_date])
      date_range = dates.get_range

      @id = input[:id]
      @room = input[:room]
      @dates = dates
      @date_range = date_range
      @cost = calculate_cost
    end

    def calculate_cost
      cost = RATE * @dates.find_num_nights
    end
  end
end
