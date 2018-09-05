require_relative 'hotel_helper'

# class Room creates instances of Room
# (with room number and a calendar of availability)
module Hotel
  class Room
    attr_reader :id
    attr_accessor :status_by_date

    def initialize(id)
      @id = id
      @status_by_date = create_calendar
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
  end
end
