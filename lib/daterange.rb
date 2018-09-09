# Optional - for developer use
require "pry"
require "awesome_print"

#TODO: .parse method!

module HotBook
# The DateRange class compares and does calculations on other DateRanges
# Refer to Date gem docu to understand what date format to use (i.e. y-m-d)
  class DateRange
    require "date"
    attr_reader :start_date, :end_date

    def initialize(start_date:, end_date:)
      @start_date = Date.parse(start_date.to_s)
      @end_date = Date.parse(end_date.to_s)
      raise ArgumentError, "Invalid range #{self}: End must be > Start)" unless
                           @end_date > @start_date
    end

    def duration
      return (end_date - start_date).to_i
    end

    def conflict?(other)
      if self.start_date >= other.end_date || self.end_date <= other.start_date
        return false
      else
        return true
      end
    end

    def to_range
      return (@start_date..@end_date)
    end
  end

end
