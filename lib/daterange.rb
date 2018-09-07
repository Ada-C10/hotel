# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
# The DateRange class compares and does calculations on other DateRanges
# Refer to Date gem documentation to understand what date format to use (i.e. y-m-d)
  class DateRange
    require "date"
    attr_reader :start_date, :end_date

    def initialize(start_date:, end_date:)
      @start_date = Date.parse(start_date.to_s)
      @end_date = Date.parse(end_date.to_s)
      is_valid?
    end

    def is_valid?
      raise ArgumentError, "Invalid DateRange #{self}: End must be > Start)" unless end_date > start_date
      return true
    end

    def duration
      return (end_date - start_date).to_i
    end

    def is_after?(oldrange) # caution: easy to switch...
      if self.is_valid?
        return oldrange.end_date <= start_date
      end
    end

  end
end
