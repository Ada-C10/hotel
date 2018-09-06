require 'date'
require 'room_booker'
module Hotel
  class Duration

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    end

    def number_of_nights
      return (@end_date - @start_date).to_i
    end

    def is_overlapping(start_booked_date, end_booked_date)
      reservation_date_range = (@start_date...@end_date)
      booked_dated_range = (Date.parse(start_booked_date)...Date.parse(end_booked_date))

      return reservation_date_range.include?(booked_dated_range) ? true : false

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
