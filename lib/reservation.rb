require 'date'

module Hotel
  class Reservation
    attr_reader :id, :room, :check_in, :check_out, :daily_rate

    def initialize(input)

      unless /\d{4}-\d{1,2}-\d{1,2}/.match(input[:check_in]) && /\d{4}-\d{1,2}-\d{1,2}/.match(input[:check_out])
        raise StandardError, "Improper date format: date must be entered as YYYY-MM-DD."
      end

      @id = input[:id].to_i
      @room = input[:room] # num-->obj in BookingSystem create_reservation??
      @check_in = Date.parse(input[:check_in])
      @check_out = Date.parse(input[:check_out])
      @daily_rate = input[:cost] ? input[:cost] : 200

      unless @check_out > @check_in
        raise StandardError, "Invalid date range: end date must occur after start date."
      end
    end

    def dates_reserved()
      # don't include check out date
      return (@check_in...@check_out).to_a
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
#   check_in: "2004,5,6",
#   check_out: "2004-7-4"})
#
# p res.dates_reserved.class
# p res.dates_reserved[0].class
