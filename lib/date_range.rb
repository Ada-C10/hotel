require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      if check_in > check_out || check_in < Date.today || check_out < Date.today
        raise ArgumentError, "Invalid dates given"
      else
        @check_in = check_in
        @check_out = check_out
      end
    end

    def get_total_days
      return (@check_out - @check_in).to_i
    end

    def is_within_date_range(date)
      if date.class != Date
        return false
      end
      return date >= @check_in && date < @check_out
    end

  end
end
