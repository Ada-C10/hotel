module Hotel
class Reservation

  attr_reader :room, :start_date, :end_date, :rate

  def initialize(room, daterange, rate = 200)

    unless room.is_a?(Integer) && room >= 1 && room <= 20
      raise ArgumentError, "Room number is not valid number"
    end
    unless rate.is_a?(Numeric) && rate > 0
      raise ArgumentError, "Rate is not valid number"
    end

    @room = room
    @daterange = daterange
    @rate = rate

  end

  def total_cost
    return (@daterange.total_nights * rate).round(2)
  end

end
end
