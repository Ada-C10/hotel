require_relative 'hotel_helper'

# class Room manages room availablility (status)
# (with room number and a calendar of availability)
module Hotel
  class Room
    attr_reader :id, :block
    attr_accessor :status_by_date

    def initialize(id)
      @id = id
      @status_by_date = create_calendar
    end

    def self.change_status_of_room(rooms, id, check_in: Date.today, check_out: Date.today + 2)
      room = Room.find_room(rooms, id)
      all_dates = DateRange.create_date_array(check_in, check_out)
      all_dates.each do |date|
        room.status_by_date[date] = :UNAVAILABLE
      end
    end

    def self.is_available?(rooms, id, check_in: Date.today, check_out: Date.today + 2)
      room = find_room(rooms, id)
      all_dates = DateRange.create_date_array(check_in, check_out)

      all_dates.each do |date|
        if room.status_by_date[date] == :UNAVAILABLE
          return false
        end
      end

      return true
    end

    def self.all_available_rooms(rooms, start_date, end_date)
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
    
    private
    def create_calendar
      room_calendar = {}
      starting_date = Date.today
      ending_date = Date.today + 365

      (starting_date..ending_date).each do |date|
        room_calendar[date] = :AVAILABLE
      end

      return room_calendar
    end

    def self.find_room(rooms, id)
      return rooms.find {|r| r.id == id}
    end
  end
end
