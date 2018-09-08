require 'date'

module Hotel
  class Reservation
    attr_reader :check_in_date, :check_out_date

    def initialize(input)
      @check_in_date = input[:check_in_date]

      @check_out_date = input[:check_out_date]
        raise StandardError, "Checkout date cannot be before checkin date" unless check_in_date < check_out_date
      @room_number = input[:room_number]
    end

    def checkin_num_to_date
      return Date.parse("#{check_in_date}")
    end

    def checkout_num_to_date
      return Date.parse("#{check_out_date}")
    end

    def date_range
      date_range = [*checkin_num_to_date...checkout_num_to_date]
      return date_range
    end

    def calculate_booking_cost
      cost = date_range.length * 200
      return cost
    end
  end
end
