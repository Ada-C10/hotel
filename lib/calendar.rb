require_relative 'hotel_helper'

# class Calendar finds available rooms for given date ranges
module Hotel
  class Calendar
    def self.available_rooms(rooms, start_date, end_date)
      list = []
      date_array = DateRange.create_date_array(start_date, end_date)

      rooms.each do |room|
        status = room.status_by_date.values_at(*date_array)
        if status.uniq.length == 1 && status.include?(:AVAILABLE)
          list << room.id
        end
      end

      list = nil if list.empty?

      return list
    end
  end
end
