require 'date'

class Reservation
  attr_reader :check_in_date, :check_out_date, :room_number

  def initialize(check_in_date, check_out_date)
    @check_in_date = Date.parse(check_in_date)
    @check_out_date = Date.parse(check_out_date)
    raise ArgumentError, "invalid dates" if @check_in_date >= @check_out_date
    @room_number = nil
  end

  def reservation_dates
    dates = []
    date = @check_in_date
    while date < @check_out_date
      dates << date
      date += 1
    end
    return dates
  end

  def length_of_stay
    duration = check_out_date - check_in_date
    return duration
  end

  def total_cost
  end
end
