module Hotel
  class DateRange
    attr_reader  :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def overlaps?(other)
      other_range = other.get_range
      my_range = self.get_range
      return (other_range & my_range).empty? ? false : true
    end

    def get_range
      return [*@start_date...@end_date]
    end

    def find_num_nights
      return @end_date - @start_date
    end
  end
end
