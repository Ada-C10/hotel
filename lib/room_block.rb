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
    unless rooms.length <= 5
      raise ArgumentError, "Cannot have more than 5 rooms"
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

  def book_reservation(room, start_date, end_date)

      unless available_rooms.include?(room)
        raise ArgumentError, "This room cannot be booked within this block."
      end

      unless match_date?(start_date, end_date)
        raise ArgumentError, "Date range does not match block"
      end

      reservation = Hotel::Reservation.new(room, start_date, end_date, @rate)
      @reservations << reservation
      return reservation
  end

  def match_date?(start_date, end_date)
    return start_date == @start_date && end_date == @end_date
  end

  def available_rooms
    return @rooms - @reservations.map{ |reservation| reservation.room }
  end


end
end
