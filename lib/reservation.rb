require 'date'
require 'room'

module Hotel
  class Reservation
    attr_reader :start_day, :end_day, :room, :id
    def initialize(room, start_day, end_day)
      @room = room
      @start_day = Date.parse(start_day)
      @end_day = Date.parse(end_day)
      @total_nights = nights_in_reservation
      end
    


def nights_in_reservation
  nights = @end_day - @start_day
  return nights.to_i
end

    def total_cost
      @total_nights * 200
    end

end
end
