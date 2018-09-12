
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
      @total_cost = @date_range.count * COST_OF_ROOM #wanted it to be @rooms.length *
    end

    def find_reservation(date)
      date = Date.parse(date)
      return self.date_range.include? date
    end

    def overlaps?(check_in, check_out)
      existing_check_in = self.check_in
      existing_check_out = self.check_out
      if existing_check_in < check_out && existing_check_in > check_in
        return true
      elsif check_in < existing_check_out && existing_check_out < check_out
      else
        return false
      end
    end


      #check overlap
    #reservations_manager.reservations
    # def do_conflict?(dates)
    #   reservation.date_range.include? date
    # end

    # def self.calculate_reservation_cost
    #   total_cost = @rooms.length * @date_range.count * COST_OF_ROOM
    #   return total_cost
    # end
  end
end
