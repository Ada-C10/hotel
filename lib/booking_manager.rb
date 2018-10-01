class BookingManager

  attr_reader :calendar

  def initialize(calendar)
    @calendar = calendar
  end

  def reserve_room(check_in, check_out)
    reservation = Reservation.new(check_in, check_out)
    calendar.add_reservation(reservation)
  end

  def reserve_block(check_in, check_out, number_of_rooms)
    block = Block.new(check_in, check_out, number_of_rooms)
    calendar.add_block(block)
  end

  def reserve_block_room(block)
    available = block.rooms.select do |room, status|
      status == :available
    end

    raise StandardError, "No availability." if available.empty?

    reserved_room = available.first[0]

    block.set_unavailable_status(reserved_room)

    return reserved_room
  end

end
