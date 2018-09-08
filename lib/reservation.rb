require 'date'

module Hotel
  class Reservation
    attr_reader :id, :room, :check_in, :check_out, :daily_rate

    def initialize(input)

      @id = input[:id].to_i
      @room_num = input[:room_num]
      #TODO: date_range CAL instantiate here
      @check_in = Date.parse(input[:check_in])
      @check_out = Date.parse(input[:check_out])
      @daily_rate = input[:daily_rate] ? input[:daily_rate] : 200

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
