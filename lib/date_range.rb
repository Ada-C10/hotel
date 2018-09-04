require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      if start_date > end_date || start_date < Date.today || end_date < Date.today
        raise ArgumentError, "Invalid dates given"
      else
        @start_date = start_date
        @end_date = end_date
      end
    end

    def get_total_days
      return (@end_date - @start_date).to_i
    end

  end
end
