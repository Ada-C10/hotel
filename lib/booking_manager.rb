class BookingManager

  attr_reader :calendar

  def initialize(calendar)
    @calendar = calendar
  end

  def add_reservation(reservation)
    room = calendar.available_rooms(reservation).first

    raise StandardError, "No availability." if room.nil?
  
    reservation.get_all_dates.each do |date|
      calendar.room_assignments[room] << date
    end

    return room
  end

  def add_block(block)
    available_rooms = calendar.available_rooms(block)
    block_size = block.number_of_rooms

    if available_rooms.length < block_size
      raise StandardError, "No availability."
    end

    block_rooms = available_rooms[0..(block_size - 1)]

    block_rooms.each do |room|
      calendar.room_assignments[room] << block.get_all_dates
      block.rooms[room] = :available
    end

    return block_rooms
  end

  def reserve_block_room(block)
    available = block.rooms.select do |room, status|
      status == :available
    end

    raise StandardError, "No availability." if available.empty?

    reserved_room = available.first[0]

    block.rooms[reserved_room] = :unavailable

    return reserved_room
  end

end
