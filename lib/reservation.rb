class Reservation
  attr_reader :date_range, :begin_date, :end_date, :room_num, :rate, :cost

  # def initialize(begin_date, end_date, room_num, rate)
  def initialize(date_range, room_num, rate)
    @begin_date = date_range[:begin_date]
    @end_date = date_range[:end_date]
    @room_num = room_num
    raise ArgumentError if @room_num == nil
    @rate = rate
    @cost = ( date_range[:end_date] - date_range[:begin_date] ) * rate
  end
end
