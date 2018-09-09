require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      if (end_date < start_date)
        raise StandardError
      end

      @start_date = start_date
      @end_date = end_date
    end

    def duration
      return (@end_date - @start_date).to_i
    end

    def include?(date)
      return (start_date <= date && end_date > date)
    end
  end
end
