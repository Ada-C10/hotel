class Reservation
  attr_reader :room_num, :start_time, :end_time, :price

  def initialize(attributes)
    @room_num = attributes[:room_num]
    @start_time = attributes[:start_time]
    @end_time = attributes[:end_time]
    @price = attributes[:price]
  end

  def total_cost
    total_cost = 0
    return total_cost = ((end_time - start_time) * price).round(2)
  end

  def date_range
    return self.start_time...self.end_time
  end
  def reservations_on(date)
    raise ArgumentError.new"#{date} must be instance of Date" unless date.instance_of? Date
    reservations_on_date = []
    TrackingSystem.reservations.each do |reservation|
      if reservation.include?(date)
        reservations_on_date << reservation
      end
    end
    if reservations_on_date.empty?
      raise ArgumentError.new"There are no reservations on #{date}"
    else
      return reservations_on_date
    end
  end

  def ranges_overlap?(other_date_range)
    self.date_range.include?(other_date_range.first) || other_date_range.include?(self.start_time)
  end

  def include?(date)
    if self.date_range.include?(date)
      return true
    else
      return false
    end
  end

  def number_of_nights
    return (self.end_time - self.start_time).to_i
  end


end
