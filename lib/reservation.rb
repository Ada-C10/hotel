require 'date'

class Reservation
  class InvalidDateError < StandardError ; end

  PRICE = 200

  attr_reader :check_in, :check_out, :number_of_nights, :cost

  def initialize(check_in, check_out)
    @check_in = date_format(check_in)
    @check_out = date_format(check_out)
    @number_of_nights = number_of_nights
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

    if nights.numerator <= 0
      raise InvalidDateError.new("Invalid date range.")
    end

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
