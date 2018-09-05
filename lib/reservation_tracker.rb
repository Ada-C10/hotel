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
      reservation.date_within_reservation?(date)
    end

    return valid_reservations.empty? ? nil : valid_reservations
  end

  def available_rooms(start_date, end_date)

    unavailable_rooms = []

    @reservations.each do |reservation|
      if reservation.daterange_within_reservation?(start_date, end_date)
        unavailable_rooms << reservation.room
      end
    end

    @blocks.each do |block|
      if block.daterange_within_block?(start_date, end_date)
        unavailable_rooms << reservation.room
      end
    end

    return ([*1..20] - unavailable_rooms.uniq)
  end

  def book_reservation(room, start_date, end_date)

    unless start_date.is_a?(Date) && end_date.is_a?(Date)
      raise ArgumentError, "Invalid date format"
    end

    unless available_rooms(start_date, end_date).include?(room)
      raise StandardError, "Room is not available for these dates."
    end

    reservation = Hotel::Reservation.new(room, start_date, end_date)
    @reservations << reservation
    return reservation
  end

  def create_block(rooms, start_date, end_date, rate = 200)

    block = Hotel::RoomBlock.new(rooms, start_date, end_date, rate)
    @blocks << block
    return block
  end

  def book_block_reservation(room, start_date, end_date)

    block = find_matching_block(start_date, end_date)
    block.book_reservation(room, start_date, end_date)

  end

  def find_matching_block(start_date, end_date)
    return @blocks.find do
      |block| block.start_date == start_date && block.end_date == end_date
    end
  end

end
end
