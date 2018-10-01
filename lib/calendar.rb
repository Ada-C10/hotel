class Calendar

  attr_reader :rooms, :room_assignments

  def initialize(number_of_rooms)
    @rooms = [*1..(number_of_rooms)]
    @room_assignments = Hash[ @rooms.collect { |room| [room, []] } ]
  end

  def add_reservation(reservation)
    room = available_rooms(reservation).first

    raise StandardError, "No availability." if room.nil?

    reservation.get_all_dates.each do |date|
      room_assignments[room] << date
    end

    return room
  end

  def add_block(block)
    available_rooms = available_rooms(block)
    block_size = block.number_of_rooms

    if available_rooms.length < block_size
      raise StandardError, "No availability."
    end

    block_rooms = available_rooms[0..(block_size - 1)]

    block_rooms.each do |room|
      room_assignments[room] << block.get_all_dates
      block.set_available_status(room)
    end

    return block_rooms
  end

  def reservations(date)
    date = Date.parse(date)
    reservations = room_assignments.select { |room, dates|  dates.flatten.include? (date) }.keys
  end

  def available_room?(room, reservation)
    dates = reservation.get_all_dates
    if dates.any? { |date| room_assignments[room].flatten.include? (date)}
      return false
    end

    return true
  end

  def available_rooms(reservation)
    available_rooms = rooms.select { |room| available_room?(room, reservation)}
  end



end
