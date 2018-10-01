
# require 'Date'

module Hotel
  COST_OF_ROOM = 200
  class Reservation
    attr_reader :id, :check_in, :check_out, :rooms, :total_cost, :date_range, :discount_rate



    def initialize(id_num, number_of_rooms:1, check_in:, check_out:, discount_rate: 1, block_id:'')
      @id = id_num
      @block_id = block_id
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @date_range = (@check_in...@check_out)
      @rooms = []
      @discount_rate = discount_rate
      #change this to standard error / rescue
      if @check_out != nil
        if @check_out <= @check_in
        raise ArgumentError, "Invalid date range"
        end
      end
    end

    def find_reservation(date)
      date = Date.parse(date)
      return self.date_range.include? date
    end

    def overlaps?(check_in, check_out)
      existing_check_in = self.check_in
      existing_check_out = self.check_out
      if existing_check_in <= check_out && existing_check_in >= check_in
        return true
      elsif check_in <= existing_check_out && existing_check_out <= check_out
        return true
      else
        return false
      end
    end

    def total_cost
      total_cost =  self.date_range.count * self.rooms.length * COST_OF_ROOM * self.discount_rate
      return total_cost
    end

  end
end
