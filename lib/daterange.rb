module HotBook
# The DateRange class compares and does calculations on other DateRanges
# Refer to Date gem docu to understand what date format to use (i.e. y-m-d)
  class DateRange
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

# Does daterange conflict with another daterange?
    def conflict?(other)
      if start_date >= other.end_date || end_date <= other.start_date
        return false
      else
        return true
      end
    end

# Range only includes overnights and EXCLUDES checkout day.
# should change this to "contains(date)"
    def to_range
      return (@start_date...@end_date)
    end
  end

end
