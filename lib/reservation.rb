require 'date'

class Reservation
  attr_reader :check_in_date, :check_out_date

  def initialize(check_in_date, check_out_date)
    @check_in_date = Date.parse(check_in_date)
    @check_out_date = Date.parse(check_out_date)
    @room_number = nil
  end

  def reserve_room
    # check date
    # select room
  end

  def total_cost
  end
end
