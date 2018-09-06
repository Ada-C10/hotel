require_relative '../lib/date_range'
require 'pry'


module Hotel
  class Reservation < DateRange

    attr_reader :cost, :reservation_id

    def initialize(cost)
      @cost = cost.to_f
      @reservation_id = Reservation.generate_id
    end
    # - Generate an reservation ID
    def self.generate_id
      rand_array = []

      3.times do
        rand_num = rand(1..9).to_s
        rand_array << rand_num
      end

      3.times do
        rand_letter = ('A'..'Z').to_a.sample.to_s
        rand_array << rand_letter
      end

      rand_array.insert(3, "-")
      return rand_array * "".to_s
    end
    # - Find total cost
    def total_cost
      total_cost = @cost * duration_of_stay
      return total_cost
    end




    # {res_id: msmsm, cost: $200, nights:2 }

  end
end
