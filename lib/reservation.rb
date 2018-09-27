class Reservation
  attr_reader :date_range, :room_num, :rate, :cost

  def initialize(date_range, room_num, rate)
    @date_range = {}
    @date_range[:begin_date] = date_range[:begin_date]
    @date_range[:end_date] = date_range[:end_date]
    @room_num = room_num
    @rate = rate
  end

  def cost
    @cost = ( date_range[:end_date] - date_range[:begin_date] ) * rate
  end
end
