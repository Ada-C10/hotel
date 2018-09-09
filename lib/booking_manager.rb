class BookingManager

  attr_reader :calendar

  def initialize(calendar)
    @calendar = calendar
  end

  def add_reservation(reservation)
    dates = reservation.get_all_dates
    room = calendar.available_rooms(reservation).first

    if room.nil?
      return "No available rooms."
    end

    dates.each do |date|
      calendar.room_assignments[room] << date
    end

    return room
  end

  def add_block(block)
    dates = block.get_all_dates
    available_rooms = calendar.available_rooms(block)
    block_size = block.number_of_rooms

    if available_rooms.length < block_size
      return "Not enough available rooms."
    end

    block_rooms = available_rooms[0..(block_size - 1)]
    block_rooms.each do |room|
      calendar.room_assignments[room] << dates
      block.rooms[room] = :available
    end

    return block_rooms
  end

  def reserve_block_room(block)
    available = block.rooms.select do |k, v|
      v == :available
    end

    if available.empty?
      return "No available rooms in block."
    end

    reserved_room = available.first[0]
    block.rooms[reserved_room] = :unavailable
    return reserved_room
  end

end
