require_relative 'calendar'

module Hotel
  class Reservation < Calendar
    attr_reader :id, :room_num, :daily_rate

    def initialize(check_in:, check_out:, id:, room_num:, daily_rate: 200)
      super(check_in: check_in, check_out: check_out)

      @id = id.to_i
      @room_num = room_num.to_i
      @daily_rate = daily_rate.to_f

    end

    def total_stay_cost()
      length_in_days = @check_out - @check_in
      return @daily_rate * length_in_days
    end
  end
end


# res = Hotel::Reservation.new(
#   id: "2",
#   room_num: "3",
#   check_in: "2004-5-6",
#   check_out: "2004-7-4")
#
# p res.create_date_range
# p res.create_date_range.class
