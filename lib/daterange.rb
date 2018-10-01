module Hotel
class DateRange

  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)

    @start_date = start_date
    @end_date = end_date

    unless start_date.is_a?(Date) && end_date.is_a?(Date)
      raise ArgumentError, "Start and/or End dates are not in correct format"
    end

    unless total_nights > 0
      raise StandardError, "Invalid start/end dates"
    end

  end

  def total_nights
    return (end_date - start_date).to_i
  end

  def valid_date?(date)
    return (date >= @start_date && date < @end_date)
  end

  def valid_daterange?(start_date, end_date)
    return valid_date?(start_date) || valid_date?(end_date) ||
    (start_date < @start_date && end_date > @end_date)
  end

end
end
