require 'date'

module Hotel
  class ReservationCreator
    attr_reader :check_in_date, :check_out_date
    attr_accessor :room_number

    def initialize(input)
      @check_in_date = Date.parse("#{input[:check_in_date]}")

      @check_out_date = Date.parse("#{input[:check_out_date]}")
        raise StandardError, "Checkout date cannot be before checkin date" unless input[:check_in_date] < input[:check_out_date]
      @room_number = input[:room_number].nil? ? [] : input[:room_number]
    end

    def date_range
      date_range = [*check_in_date...check_out_date]
      return date_range
    end

    def calculate_booking_cost
      cost = date_range.length * 200
      return cost
    end
  end
end
