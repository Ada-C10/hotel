module Hotel
  class DateRange
    class InvalidDateError < StandardError; end
    class DatesOrderError < StandardError; end

    attr_reader  :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date

      checks_dates_validity(start_date, end_date)
      check_dates_order(start_date, end_date)
    end

    def overlaps?(other)
      other_range = other.get_range
      my_range = self.get_range
      return (other_range & my_range).empty?
    end

    def get_range
      return [*@start_date...@end_date]
    end

    def find_num_nights
      return @end_date - @start_date
    end

    private
    
    def checks_dates_validity(start_date, end_date)
      unless (@start_date.is_a?(Date) && @end_date.is_a?(Date))
        raise StandardError.new("That is not a Date type")
      end
    end

    def check_dates_order(start_date, end_date)
      if end_date < start_date
        raise DatesOrderError.new("Start date must be before end date")
      end
    end
  end
end
