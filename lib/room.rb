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

    def self.change_status_of_room(rooms, id, start_date: Date.today, end_date: Date.today + 2)
      room = Room.find_room(rooms, id)
      all_dates = DateRange.create_date_array(start_date: start_date, end_date: end_date)
      all_dates.each do |date|
        room.status_by_date[date] = :UNAVAILABLE
      end
    end

    def self.all_available_rooms(rooms, start_date: Date.today, end_date: Date.today + 2)
      list = []
      date_array = DateRange.create_date_array(start_date: start_date, end_date: end_date)

      rooms.each do |room|
        status = room.status_by_date.values_at(*date_array)
        if status.uniq.length == 1 && status.include?(:AVAILABLE)
          list << room.id
        end
      end

      if list.empty?
        raise ArgumentError.new("No available rooms.")
      end

      return list
    end

    private
    def create_calendar
      room_calendar = {}
      start_date = Date.today
      end_date = Date.today + 365

      (start_date..end_date).each do |date|
        room_calendar[date] = :AVAILABLE
      end

      return room_calendar
    end

    def self.find_room(rooms, id)
      return rooms.find {|r| r.id == id}
    end
  end
end
