require 'date'

module Hotel
  class Calendar
    attr_reader :check_in, :check_out

    def initialize(check_in:, check_out:)

      unless /\d{4}-\d{1,2}-\d{1,2}/.match(check_in) && /\d{4}-\d{1,2}-\d{1,2}/.match(check_out)
        raise StandardError, "Improper date format: date must be entered as YYYY-MM-DD."
      end

      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)

      unless @check_in < @check_out
        raise StandardError, "Invalid date range: end date must occur after start date."
      end
    end

  def has_date?(other_date)
    other_date = Date.parse(other_date)
    if (other_date >= @check_in) && (other_date <= @check_out - 1)
      return true
    else
      return false
    end
  end

  def overlap?(other_dates) # param: Calendar obj
    if !(other_dates.check_in <= @check_out-1) || !(other_dates.check_out-1 >= @check_in)
      return false
    else
      return true
    end
  end

  def nights_reserved()
    return @check_out - @check_in
  end
  end
end
