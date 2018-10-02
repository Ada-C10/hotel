require 'date'
module Hotel
  class Reservation
    class InvalidDateError < StandardError ; end

    PRICE = 200

    attr_reader :check_in, :check_out, :cost

    def initialize(check_in, check_out)
      @check_in = date_format(check_in)
      @check_out = date_format(check_out)

      if number_of_nights <= 0
        raise Hotel::Reservation::InvalidDateError.new("Invalid date range.")
      end

      @cost = PRICE * number_of_nights
    end

    def date_format(date)
      pattern = /^\d{6}$/

      if pattern.match(date).nil?
        raise ArgumentError.new("Date format: YYMMDD.")
      else
        Date.parse(date)
      end
    end

    def number_of_nights
      nights = check_out - check_in
      return nights.numerator
    end

    def get_all_dates
      all_dates = []
      date = check_in

      number_of_nights.times do
        all_dates << date
        date += 1
      end

      return all_dates
    end
  end
end
