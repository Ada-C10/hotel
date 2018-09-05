require 'time'
require 'room'

module Hotel
  class Reservation
    attr_reader :start_day, :end_day, :room, :id
    def initialize(room, start_day, end_day)
      @room = room
      @start_day = start_day
      @end_day = end_day
    end
end
end
