module Hotel
  class DateRange
    attr_reader  :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date

      raise ArgumentError.new("Start date must be before end date") if @end_date < @start_date
    end

    def overlaps?(other)
      other_range = other.get_range.to_a
      my_range = self.get_range.to_a
      return (other_range & my_range).empty?
    end

    def get_range
      get_range = (@start_date...@end_date)
      return get_range
    end

    def get_reservation_period
      get_reservation_period = @end_date - @start_date
      return get_reservation_period
    end
  end
end
