require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out, :dates_booked

    def initialize(check_in, check_out)
      if check_in >= check_out
        raise StandardError, "Your check in and check out date is not valid!"
      elsif !check_in.is_a?(Date) || !check_out.is_a?(Date)
        raise ArgumentError, "You must input Dates in the date range!"
      end
      @check_in = check_in
      @check_out = check_out
      @dates_booked = (check_in...check_out).to_a
    end

    def overlaps?(range)
      @dates_booked & range.dates_booked == [] ? false : true
    end
  end
end
