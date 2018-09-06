require_relative 'hotel_helper'

module Hotel
  class Calendar
    
  end
end
# As an administrator, I can view a list of rooms that are not reserved for a given date range

#
# Calendar.method_name(rooms, date_range) -> returns list of available rooms for range
# def available_rooms(check_in, check_out)
#   date_array = *(Date.parse(check_in)...Date.parse(check_out))
#
#   @rooms.each do |room|
#     date_array.each do |date|
#       if room.calendar[date] == :UNAVAILABLE
#         return nil
#       end
#     end
#   end
#
#   return :AVAILABLE
# end

# use class methods
