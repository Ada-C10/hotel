BLOCK_DISCOUNT = 0.80

module Hotel
  class Reservation
    attr_reader :id, :block_id, :room, :cost, :date_range

    def initialize(input)
      @id = input[:id]
      @block_id = input[:block_id].nil? ? nil : input[:block_id]
      @room = input[:room]
      @date_range = input[:date_range]
      @cost = calculate_cost
    end

    def calculate_cost
      num_of_nights = @date_range.find_num_nights
      rate = @room.rate
      reg_cost = (rate * num_of_nights).round(2)
      blocked_cost = (reg_cost * BLOCK_DISCOUNT).round(2)
      @block_id.nil? ? reg_cost : blocked_cost
    end
  end
end
