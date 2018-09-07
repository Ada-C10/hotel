require 'pry'
require 'time'
require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date

      if (@start_date && @end_date) && (@start_date >= @end_date)
        raise ArgumentError.new("Invalid time - start time is after end time")
      end
    end

    def get_date_range

      reserve_dates_range = (Date.parse(@start_date)...Date.parse(@end_date))
      return reserve_dates_range
    end

    def check_overlap(requested_dates)
      #
      x = self.get_date_range
      return (x.to_a & requested_dates.to_a).empty?
    end


    def duration_cal

      duration = Date.parse(@end_date) - Date.parse(@start_date)
      return duration
    end
  end
end
