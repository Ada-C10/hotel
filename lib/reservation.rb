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
      return @daily_rate * nights_reserved
    end
  end
end
