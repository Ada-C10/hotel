class Reservation
  attr_reader :check_in, :check_out, :number_of_nights, :cost
  PRICE = 200
  def initialize(check_in, check_out)
    # raise StandardError, "Invalid check-in date format." unless check_in =~ (/\d{6}/)
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    @number_of_nights = @check_out.mday - @check_in.mday
    @cost = PRICE * number_of_nights
  end
  def get_all_dates
    all_dates = []
    date = check_in
    number_of_nights.times do
      all_dates << date
      date = date.next
    end
    return all_dates
  end
end
