class Reservation
  attr_reader :room_num, :begin_date, :end_date, :room_num, :rate, :cost

  def initialize(begin_date, end_date, room_num, rate)
    @begin_date = begin_date
    @end_date = end_date
    @room_num = room_num
    raise ArgumentError if @room_num == nil
    @rate = rate
    @cost = ( end_date - begin_date ) * rate
  end
end
