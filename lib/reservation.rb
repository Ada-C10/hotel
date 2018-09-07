require_relative 'date_range'

RATE = 200

module Hotel
  class Reservation
    attr_reader :id, :room, :cost, :date_range

    def initialize(input)
      @id = input[:id]
      @room = input[:room]
      @date_range = input[:date_range]
      @cost = calculate_cost
    end

    def calculate_cost
      cost = RATE * @date_range.find_num_nights
    end
  end
end
