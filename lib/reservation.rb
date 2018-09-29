require 'date'

module Hotel
  class Reservation
    attr_reader :id, :room, :start_date, :end_date, :room_cost

    def initialize(id, room, start_date, end_date, room_cost: 200)
      @id = id
      @room = room
      if start_date.instance_of?Date
        @start_date = start_date
      else
        @start_date = Date.parse(start_date)
      end

      if end_date.instance_of?Date
        @end_date = end_date
      else
        @end_date = Date.parse(end_date)
      end

      if @end_date < @start_date
        raise StandardError, "invalid date range"
      end

      @room_cost = room_cost
    end

    def cost
      # https://stackoverflow.com/questions/4502245/how-can-i-find-the-number-of-days-between-two-date-objects-in-ruby
      total_nights = end_date.mjd - start_date.mjd

      cost = total_nights * room_cost

      return cost
    end
  end
end
