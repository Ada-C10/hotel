module Hotel
class RoomBlock

  attr_reader :rooms, :daterange, :rate

  def initialize(rooms, daterange, rate = 200)

    unless daterange.is_a?(Hotel::DateRange)
      raise ArgumentError, "daterange is not daterange object"
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
    @daterange = daterange
    @rate = rate
    @reservations = []
  end

  def book_reservation(room, daterange)

      unless available_rooms.include?(room)
        raise ArgumentError, "This room cannot be booked within this block."
      end

      unless match_date?(daterange)
        raise ArgumentError, "Date range does not match block"
      end

      reservation = Hotel::Reservation.new(room, daterange, @rate)
      @reservations << reservation
      return reservation
  end

  def match_date?(daterange)
    return daterange.start_date == @daterange.start_date &&
    daterange.end_date == @daterange.end_date
  end

  def available_rooms
    return @rooms - @reservations.map{ |reservation| reservation.room }
  end


end
end
