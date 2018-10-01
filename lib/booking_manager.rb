class BookingManager
  class NoAvailabilityError < StandardError ; end

  attr_reader :calendar, :reservations, :blocks

  def initialize(calendar)
    @calendar = calendar
    @reservations = []
    @blocks = []
  end

  def reserve_room(check_in, check_out)
    reservation = Reservation.new(check_in, check_out)
    room = calendar.add_reservation(reservation)
    @reservations << [reservation, room]
  end

  def reserve_block(check_in, check_out, number_of_rooms)
    block = Block.new(check_in, check_out, number_of_rooms)
    rooms = calendar.add_block(block)
    @blocks << block
  end

  def reserve_block_room(block)
    available = block.rooms.select do |room, status|
      status == :available
    end

    if available.empty?
      raise NoAvailabilityError.new("No availability.")
    end

    reserved_room = available.first[0]

    block.set_unavailable_status(reserved_room)

    return reserved_room
  end

end
