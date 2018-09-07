require_relative 'hotel_helper'

#class DateRange formats the check in and out times
# as an array of dates for the entire stay
module Hotel
  class DateRange
    def self.create_date_array(start_date, end_date)
      if start_date.class != Date
        all_dates = *(Date.parse(start_date)...Date.parse(end_date))
      else
        all_dates = *(start_date...end_date)
      end
      return all_dates
    end
  end
end
