class Reservation
  attr_reader :id, :room_num, :begin_date, :end_date, :rate, :cost

  def initialize(id, begin_date, end_date, rate)
    @id = id
    @begin_date = begin_date
    @end_date = end_date
    @rate = rate
    @cost = ( end_date - begin_date ) * rate
  end
end
