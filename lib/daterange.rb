# Optional - for developer use
require "pry"
require "awesome_print"

#TODO: .parse method!

module HotBook
# The DateRange class compares and does calculations on other DateRanges
# Refer to Date gem documentation to understand what date format to use (i.e. y-m-d)
  class DateRange
    require "date"
    attr_reader :start_date, :end_date

    def initialize(start_date:, end_date:)
      @start_date = Date.parse(start_date.to_s)
      @end_date = Date.parse(end_date.to_s)
      raise ArgumentError, "Invalid range #{self}: End must be > Start)" unless @end_date > @start_date
    end

    # def is_valid?
    #   if end_date > start_date
    #     return true
    #   else
    #     raise ArgumentError, "Invalid range #{self}: End must be > Start)"
    #   end
    # end

    def duration
      return (end_date - start_date).to_i
    end

    def is_after?(oldrange) # caution: easy to switch...
      return oldrange.end_date <= start_date
    end

    # def to_range
    #   return (@start_date..@end_date)
    # end

  end
end
