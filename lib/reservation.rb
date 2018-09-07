require 'date'

class Reservation
  attr_reader :check_in_date, :check_out_date
  attr_accessor :reservation_id, :total_cost

  def initialize(check_in_date, check_out_date)
    @check_in_date = Date.parse(check_in_date)
    @check_out_date = Date.parse(check_out_date)
    raise ArgumentError, "invalid dates" if @check_in_date >= @check_out_date
    @reservation_id = 0
  end

  def length_of_stay
    duration = check_out_date - check_in_date
    return duration
  end
end
