require_relative 'hotel_helper'

# class Reservation creates instances of Reservation
# (with check-in date, check-out date, room number, and total cost)
module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room_number, :room_rate, :group_name
    attr_accessor :room_cost

    def initialize(room_number, start_date: Date.today, end_date: Date.today + 2, room_rate: 200, group_name: "")
      if start_date.class != Date
        @start_date = Date.parse(start_date)
      end

      if end_date.class != Date
        @end_date = Date.parse(end_date)
      end

      if (@end_date - @start_date) < 0
        raise StandardError.new("Invalid Date Range")
      end

      @room_number = room_number
      @room_rate = room_rate
      @group_name = group_name
    end

    # As an administrator, I can get the total cost for a given reservation
    def total_cost
      num_of_days = end_date - start_date
      room_cost = room_rate * num_of_days

      return room_cost
    end
  end
end
