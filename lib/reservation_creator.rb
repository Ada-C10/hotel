require 'date'

module Hotel
  class Reservation
    attr_reader :check_in_date, :check_out_date

    def initialize(check_in_date, check_out_date)
      @check_in_date = Date.parse("#{check_in_date}")
      @check_out_date = Date.parse("#{check_out_date}")
        raise StandardError, "Checkout date cannot be before checkin date" unless check_in_date < check_out_date
    end

    def reservation_date_range
      date_range = [*check_in_date..check_in_date]
      return date_range
    end
  end
end
