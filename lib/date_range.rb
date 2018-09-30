require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    end

    def check_valid_dates

      raise StandardError, "Invalid dates entered" if @start_date == nil || @end_date == nil

      raise StandardError, "End date cannot be before start date" if (@end_date - @start_date) <= 0
    end

    def dates_overlap?(date_range)

      booked_dates = [*date_range.start_date..date_range.end_date]
      new_dates = [*@start_date..@end_date]


      if !(new_dates.first >= booked_dates.last || new_dates.last <= booked_dates.first)
        # dates overlap
        return true
      elsif new_dates.first < booked_dates.first && new_dates.last >= booked_dates.last
        # dates are containing
        return true
      end

      return false
    end

  end
end
