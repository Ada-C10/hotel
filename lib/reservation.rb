module Hotel
class Reservation

  attr_reader :room, :start_date, :end_date, :rate

  def initialize(room, start_date, end_date, rate = 200)

    unless start_date.is_a?(Date) && end_date.is_a?(Date)
      raise ArgumentError, "Start and/or End dates are not in correct format"
    end
    unless room.is_a?(Integer) && room >= 1 && room <= 20
      raise ArgumentError, "Room number is not valid number"
    end
    unless rate.is_a?(Numeric) && rate > 0
      raise ArgumentError, "Rate is not valid number"
    end

    @room = room
    @start_date = start_date
    @end_date = end_date
    @rate = rate

    unless total_nights > 0
      raise StandardError, "Invalid start/end dates"
    end
  end

  def total_nights
    return (end_date - start_date).to_i
  end

  def total_cost
    return (total_nights * rate).round(2)
  end

  def date_within_reservation?(date)
    unless date.is_a?(Date)
      raise ArgumentError, "Invalid date input."
    end

    return (date >= @start_date && date < @end_date)
  end

  def daterange_within_reservation?(start_date, end_date)
    return date_within_reservation?(start_date) || date_within_reservation?(end_date)
  end
end
end
