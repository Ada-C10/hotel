require_relative '../lib/date_range'
require 'pry'


module Hotel
  class Reservation

    attr_reader :room_number, :cost_per_night, :date_range, :reservation_id

    def initialize(room_number, cost_per_night, check_in, check_out)
      @room_number = room_number
      @cost_per_night = cost_per_night.to_f
      @date_range = Hotel::DateRange.new(check_in, check_out)
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
      total_cost = @cost_per_night * @date_range.duration_of_stay
      return total_cost
    end

  end
end
