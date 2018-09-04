module Hotel
class Reservation

  attr_reader :room_num, :start_date, :end_date, :rate

  def initialize(room_num, start_date, end_date, rate = 200)

    unless start_date.is_a?(Date) && end_date.is_a?(Date)
      raise ArgumentError, "Start and/or End dates are not in correct format"
    end
    unless room_num.is_a?(Integer) && room_num >= 1 && room_num <= 20
      raise ArgumentError, "Room number is not valid number"
    end
    unless rate.is_a?(Numeric) && rate > 0
      raise ArgumentError, "Rate is not valid number"
    end

    @room_num = room_num
    @start_date = start_date
    @end_date = end_date
    @rate = rate

    unless total_nights > 0
      raise ArgumentError, "Invalid start/end dates"
    end
  end

  def total_nights
    return (end_date - start_date).to_i
  end

  def total_cost
    return (total_nights * rate).round(2)
  end
end
end
