module Hotel
class RoomBlock

  attr_reader :rooms, :start_date, :end_date, :rate

  def initialize(rooms, start_date, end_date, rate = 200)

    unless start_date.is_a?(Date) && end_date.is_a?(Date)
      raise ArgumentError, "Start and/or End dates are not in correct format"
    end
    unless rooms.is_a?(Array) && !rooms.empty?
      raise ArgumentError, "Room number is not valid number"
    end
    unless rate.is_a?(Numeric) && rate > 0
      raise ArgumentError, "Rate is not valid number"
    end

    @rooms = rooms
    @start_date = start_date
    @end_date = end_date
    @rate = rate
    @reservations = []
  end




end
end
