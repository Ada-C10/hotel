require 'date'

module Hotel
  class Reservation
    attr_reader :id, :room, :start_date, :end_date, :daily_rate

    def initialize(input)
      @id = input[:id].to_i
      @room = input[:room] # num-->obj in BookingSystem create_reservation
      @start_date = Date.parse(input[:start_date])
      @end_date = Date.parse(input[:end_date])
      @daily_rate = input[:cost] ? input[:cost] : 200

      unless @end_date >= @start_date
        raise StandardError, "Invalid date range: end date must occur after start date."
      end
    end

    def dates_reserved()
      # don't include end_date since that is the checkout date
      return (@start_date...@end_date).to_a
    end

    def total_stay_cost()
      length_in_days = dates_reserved().length
      return @daily_rate * length_in_days
    end

  end
end


# res = Hotel::Reservation.new({
#   id: "2",
#   room_num: "3",
#   start_date: "2004-7-1",
#   end_date: "2004-7-4"})
#
# p res.dates_reserved.class
# p res.dates_reserved[0].class
