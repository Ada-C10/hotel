require 'pry'
require 'time'
require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)

      if (@start_date && @end_date) && (@start_date >= @end_date)
        raise ArgumentError.new("Invalid time - start time is after end time")
      end
    end

    def get_date_range

      reserved_dates = @start_date...@end_date
      return reserved_dates
    end

    def check_overlap?(requested_dates)

      reserved_range = self.get_date_range
      return !(reserved_range.to_a & requested_dates.to_a).empty?
    end

    def check_include?(date)
      date_check = Date.parse(date)

      reserved = self.get_date_range
      return reserved.to_a.include?(date_check)
    end

    def duration_cal

      duration = @end_date - @start_date
      return duration
    end
  end
end
