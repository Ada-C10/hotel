module Hotel
class Reservation

  attr_reader :room, :daterange, :rate

  def initialize(room, daterange, rate = 200)

    unless room.is_a?(Integer) && room >= 1 && room <= 20
      raise ArgumentError, "Room number is not valid number"
    end
    unless rate.is_a?(Numeric) && rate > 0
      raise ArgumentError, "Rate is not valid number"
    end
    unless daterange.is_a?(Hotel::DateRange)
      raise ArgumentError, "daterange is not DateRange object"
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
