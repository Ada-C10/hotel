
# require 'Date'

module Hotel
  COST_OF_ROOM = 200
  class Reservation
    attr_reader :id, :check_in, :check_out, :rooms, :total_cost, :date_range



    def initialize(number, check_in:, check_out:)
      @id = number
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @date_range = (@check_in...@check_out)
      @rooms = []#instance of a room # reconsider- might not need but maybe
      # @total_cost = self.calculate_reservation_cost #wanted it to be @rooms.length *

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


      #check overlap
    #reservations_manager.reservations
    # def do_conflict?(dates)
    #   reservation.date_range.include? date
    # end

    def self.calculate_reservation_cost
      if @rooms.length > 1
        total_cost =  @date_range.count * @rooms.length * COST_OF_ROOM * discount_rate
      else @rooms.length == 1
        total_cost = @date_range.count * COST_OF_ROOM
      end
      return total_cost
    end
    
  end
end
