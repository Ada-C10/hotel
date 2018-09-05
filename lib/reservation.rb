class Reservation
  attr_reader :check_in, :number_of_nights, :cost
  PRICE = 200
  def initialize(check_in, number_of_nights)
    @check_in = Date.parse(check_in.to_s)
    @number_of_nights = number_of_nights
    @cost = PRICE * number_of_nights
  end
  def get_all_dates
    all_dates = []
    date = check_in
    number_of_nights.times do
      all_dates << date.next
      date = date.next
    end
    return all_dates
  end
end
