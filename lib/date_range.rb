require 'date'
require_relative 'room_booker'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    # TODO: change class name to date range?
     # change start_date t0 check-in

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    end


    def check_valid_dates

      # TODO:
      # - refactor to raise .. if ..
      # - move this to duration class?

      while @start_date == nil || @end_date == nil
        raise ArgumentError, "Invalid dates entered"
      end

      while (@end_date - @start_date) <= 0
        raise ArgumentError, "End date cannot be before start date"
      end
    end

    def dates_overlap?(date_range)
      booked_dates = (date_range.start_date...date_range.end_date)
      new_dates = (@start_date...@end_date)

      if booked_dates.include?(new_dates)
        return true
      else
        return false
      end

    end









    #checking overlapping dates?
    # input two dates to compare
    # output (boolean)


    #finding_available_room
    #input start/end date
    #output available room


    #edge cases
    #testing edge cases for date ranges


    #think...what if there's no available rooms
    #what if (9/1-9/5) reservations: (9/1-9/2), (9/4-9/5), (9/1-9/1) (start, end)

  end
end
