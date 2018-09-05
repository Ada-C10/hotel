require 'date'

# class Room creates instances of Room
# (with room number and a calendar of availability)
module Hotel
  class Room
    attr_reader :id
    attr_accessor :status_by_date

    def initialize(id)
      @id = id
      @status_by_date = {}
      (Date.parse("2018-10-01")..Date.parse("2019-09-30")).each do |date|
        @status_by_date[date] = :AVAILABLE
      end
    end

    def self.all
      rooms = []

      20.times do |i|
        rooms << Room.new(i+1)
      end

      return rooms
    end
  end
end
