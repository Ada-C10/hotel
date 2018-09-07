require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      if check_in > check_out || !is_Date(check_in) || !is_Date(check_out)
        raise ArgumentError, "Invalid dates given"
      else
        @check_in = check_in
        @check_out = check_out
      end
    end

    def get_total_days
      return (@check_out - @check_in).to_i
    end

    def is_Date(date)
      return date.class == Date
    end

    def is_within_date_range(date)
      return is_Date(date) && date >= @check_in && date < @check_out
    end
  end
end
