require 'date'
require_relative 'rooms'

module Hotel
  class Reservation
    attr_reader :check_in_date, :check_out_date

    def initialize(check_in_date, check_out_date)
      @check_in_date = Date.parse("#{check_in_date}")
      @check_out_date = Date.parse("#{check_out_date}")
        raise StandardError, "Checkout date cannot be before checkin date" unless check_in_date < check_out_date
    end

    def count_number_of_nights
      num_of_nights = check_out_date.mjd - check_in_date.mjd
      return num_of_nights
    end
  end
end
