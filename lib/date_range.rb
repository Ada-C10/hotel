require 'date'
require 'pry'

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

      booked_dates = [*date_range.start_date..date_range.end_date]
      new_dates = [*@start_date..@end_date]


      # TODO: refactor this
      
      # completely containing
      if new_dates.first < booked_dates.first && new_dates.last > booked_dates.last
        return true
      # back end
      elsif new_dates.first < booked_dates.last && new_dates.last > booked_dates.last
        return true
      # in the middle
      elsif new_dates.first > booked_dates.first && new_dates.last < booked_dates.last
        return true
      # in the front
      elsif new_dates.first < booked_dates.first && new_dates.last > booked_dates.first
        return true
      # completely before
      elsif new_dates.last < booked_dates.first
        return false
      # completely after
      elsif new_dates.first > booked_dates.last
        return false
      # ends on check-in date
      elsif new_dates.last == booked_dates.first
        return false
      # same dates
      elsif new_dates.first == booked_dates.first || new_dates.last == booked_dates.first
        return true
      end

      return false
    end


  end
end


#
# date_range_1 = Hotel::DateRange.new('2018-09-01', '2018-09-05')
#
# reservation_1.dates_overlap?






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
