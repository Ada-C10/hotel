require_relative 'hotel_helper'

# class Reservation builds instances of Reservation
# (with check-in date, check-out date, room number, and total cost)
module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :room_number
    attr_accessor :room_cost

    def initialize(room_number, check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)

      if (@check_out - @check_in) < 0
        raise StandardError.new("Invalid Date Range")
      end

      @room_number = room_number
    end

    # As an administrator, I can get the total cost for a given reservation
    def total_cost
      num_of_days = check_out - check_in
      room_cost = 200 * num_of_days

      return room_cost
    end
  end
end
