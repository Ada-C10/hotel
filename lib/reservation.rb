class Reservation

  PRICE = 200

  attr_reader :check_in, :check_out, :number_of_nights, :cost

  def initialize(check_in, check_out)
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    @number_of_nights = number_of_nights > 0 ? number_of_nights : StandardError, "Invalid date range."
    @cost = PRICE * number_of_nights
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
