require 'pry'


module Hotel
  class Block

    attr_reader :block_rooms, :reservations, :date_range, :check_in, :check_out, :discount_rate, :id

    def initialize(number, check_in:, check_out:, number_of_rooms:1, discount_rate: 0.8)
      @id = number
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @date_range = (@check_in...@check_out)
      @block_rooms = []
      @discount_rate = discount_rate
      @reservations = []
      #change this to standard error / rescue
      if @check_out != nil
        if @check_out <= @check_in
        raise ArgumentError, "Invalid date range"
        end
      end
    end


  end
end
