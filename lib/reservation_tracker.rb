module Hotel
class ReservationTracker

  attr_reader :reservations, :blocks

  def initialize
    @reservations = []
    @blocks = []
  end

  def list_rooms
    return [*1..20]
  end

  def reservations_during_date(date)

    valid_reservations = @reservations.find_all do |reservation|
      reservation.daterange.valid_date?(date)
    end

    return valid_reservations.empty? ? nil : valid_reservations
  end

  def available_rooms(start_date, end_date)

    unavailable_rooms = []

    @reservations.each do |reservation|
      if reservation.daterange.valid_daterange?(start_date, end_date)
        unavailable_rooms << reservation.room
      end
    end

    @blocks.each do |block|
      if block.daterange.valid_daterange?(start_date, end_date)
        unavailable_rooms << reservation.room
      end
    end

    return (list_rooms - unavailable_rooms.uniq)
  end

  def book_reservation(room, daterange)
    unless daterange.is_a?(Hotel::DateRange)
      raise ArgumentError, "daterange is not correct object"
    end

    unless available_rooms(daterange.start_date, daterange.end_date).include?(room)
      raise StandardError, "Room is not available for these dates."
    end

    reservation = Hotel::Reservation.new(room, daterange)
    @reservations << reservation
    return reservation
  end

  def create_block(rooms, daterange, rate = 200)

    block = Hotel::RoomBlock.new(rooms, daterange, rate)
    @blocks << block
    return block
  end

  def book_block_reservation(room, daterange)

    block = find_matching_block(daterange)
    block.book_reservation(room, daterange)
  end

  def find_matching_block(daterange)
    return @blocks.find do
      |block| block.match_date?(daterange)
    end
  end

end
end
