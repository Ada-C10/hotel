COST_OF_ROOM = 200
# require 'Date'

module Hotel
  class Reservation
    attr_reader :id, :check_in, :check_out, :rooms, :total_cost, :date_range

    def initialize(number, check_in: , check_out: )
      @id = number
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @date_range = (@check_in...@check_out)
      @rooms = []#instance of a room # reconsider- might not need but maybe
      @total_cost = 0
    end

    def find_reservation(date)
      date = Date.parse(date)
      return self.date_range.include? date
    end

      #check overlap
    #reservations_manager.reservations
    def do_conflict?(dates)
      reservation.date_range.include? date
    end

    def calculate_reservation_cost(rooms)
      total_cost = rooms.length * nights * COST_OF_ROOM
      return total_cost
    end
  end
end
