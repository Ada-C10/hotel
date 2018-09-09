
require 'Date'
COST = 200

class Reservation
  @@num = 0
  @@array_of_reservations = []
  def initialize(room_number, check_in_date, check_out_date)
    @room_number = room_number
    @check_in_date = check_in_date
    @check_out_date = check_out_date
    @@num += 1
    @@reservation_id = "2018/#{@@num}"
    @cost = cost
    check_for_dates_clash
    @@array_of_reservations << [@room_number, @check_in_date, @check_out_date, @@reservation_id, @cost]
  end

  attr_writer :room_number, :check_in_date, :check_out_date, :reservation_id

  def calculate_number_of_days
      start_date = Date.parse(@check_in_date)
      end_date = Date.parse(@check_out_date)
      number_of_days = end_date - start_date
      return number_of_days.to_i
  end

  def cost
    if @check_in_date != nil && @check_out_date != nil
      days = calculate_number_of_days
      total = (days - 1) * COST
    end
    return total
  end

  def check_for_dates_clash
    if @@array_of_reservations != []
      @@array_of_reservations.each do |array|
        if array[0] == @room_number && array[1] != nil &&
          Date.parse(@check_in_date) >= Date.parse(array[1]) &&
          Date.parse(@check_out_date) <= Date.parse(array[2])
            raise ArgumentError, "These dates are booked!!"
        end
      end
    end
  end

  def self.reservations
      return @@array_of_reservations
  end

end
