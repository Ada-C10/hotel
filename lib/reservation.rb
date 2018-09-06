require 'date'
require 'pry'

module Hotel
  class Reservation

    attr_reader :check_in, :check_out, :cost, :reservation_id

    def initialize(check_in, check_out, cost)


      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @cost = cost.to_f
      @reservation_id = Reservation.generate_id

      unless @check_out > @check_in
        raise StandardError.new("Check-out can not be before check-in. Chech-out is: #{@check_out} check-in is #{@check_in}")
      end
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

    # - Find duration of stay
    def duration_of_stay
      duration_of_stay = @check_out - @check_in
      return duration_of_stay
    end
    # - Find total cost
    def total_cost
      total_cost = @cost * duration_of_stay
      return total_cost
    end




    # {res_id: msmsm, cost: $200, nights:2 }

  end
end
