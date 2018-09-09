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
    rooms = calendar.available_rooms(block)

    if rooms.length < block.number_of_rooms
      return "Not enough available rooms."
    end

    block_rooms = rooms[0..(block.number_of_rooms - 1)]
    block_rooms.each do |room|
      # dates.each do |date|
        calendar.room_assignments[room] << dates
      # end
    end
    block_rooms.each do |room|
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

    room = available.first[0]
    block.rooms[room] = :unavailable
    return room
  end

end
