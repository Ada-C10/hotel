require 'date'

module Hotel
  class Reservation
    attr_accessor :id, :room, :start_date, :end_date, :daily_rate

    def initialize(input)
      @id = input[:id].to_i
      @room = input[:room] # num-->obj in BookingSystem create_reservation
      @start_date = Date.parse(input[:start_date])
      @end_date = Date.parse(input[:end_date])
      @daily_rate = input[:cost] ? input[:cost] : 200
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
