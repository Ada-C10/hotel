module Hotel
  class DateRange
    attr_reader  :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def confirm_valid_dates(start_date, end_date)
      check_prior_today(start_date)
      check_dates_validity?(start_date, end_date)
      check_dates_order?(start_date, end_date)
    end

    def overlaps?(other)
      other_range = other.get_range
      my_range = self.get_range
      return !(other_range & my_range).empty?
    end

    def get_range
      return [*@start_date...@end_date]
    end

    def find_num_nights
      return @end_date - @start_date
    end

    private

    def check_prior_today(start_date)
      if start_date < Date.today
        raise OldStartDateError.new("You cannot have a start date prior to Today")
      end
    end

    def check_dates_validity(start_date, end_date)
      unless (start_date.is_a?(Date) && end_date.is_a?(Date))
        raise InvalidDateError.new("That is not a Date type")
      end
    end

    def check_dates_order(start_date, end_date)
      unless start_date < end_date
        raise DatesOrderError.new("Start date must be before end date")
      end
    end
  end
end
