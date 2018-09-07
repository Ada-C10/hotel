require 'pry'
module Hotel
  class DateRange
    attr_reader  :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date

      raise ArgumentError.new("Start date must be before end date") if @end_date < @start_date
    end

    def overlaps?(other)
      other_range = other.get_range
      my_range = self.get_range
      return (other_range & my_range).empty?
    end

    def get_range
      return [*@start_date...@end_date]
    end

    def get_reservation_period
      get_reservation_period = @end_date - @start_date
      return get_reservation_period
    end
  end
end
