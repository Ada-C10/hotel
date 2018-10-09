require_relative 'hotel_helper'

#class DateRange formats the check in and out times
# as an array of dates for the entire stay
module Hotel
  class DateRange
    def self.create_date_array(start_date: Date.today, end_date: Date.today + 2)
      if start_date.class != Date
        start_date = Date.parse(start_date)
        end_date = Date.parse(end_date)
      end

      if (end_date - start_date) < 0
        raise StandardError.new("Invalid Date Range")
      end

      return *(start_date...end_date)
    end
  end
end
