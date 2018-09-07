require_relative 'hotel_helper'

# class Room manages room availablility (status)
# (with room number and a calendar of availability)
module Hotel
  class Room
    attr_reader :id
    attr_accessor :status_by_date

    def initialize(id)
      @id = id
      @status_by_date = create_calendar
    end

    def self.change_status_of_room(rooms, id, check_in, check_out)
      room = Room.find_room(rooms, id)
      all_dates = DateRange.create_date_array(check_in, check_out)
      all_dates.each do |date|
        room.status_by_date[date] = :UNAVAILABLE
      end
    end

    def self.is_available?(rooms, id, check_in, check_out)
      room = find_room(rooms, id)
      all_dates = DateRange.create_date_array(check_in, check_out)

      all_dates.each do |date|
        if room.status_by_date[date] == :UNAVAILABLE
          return false
        end
      end

      return true
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
