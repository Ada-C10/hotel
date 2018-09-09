require_relative 'block'
require_relative 'calendar'
class BookingManager

  attr_reader :calendar

  def initialize(calendar)
    @calendar = calendar
  end

  def add_reservation(reservation)
    dates = reservation.get_all_dates
    room = calendar.list_available_rooms(reservation).first
    dates.each do |date|
      calendar.room_assignments[room] << date
    end

    return "Added!"
  end

  def add_block(block)
    dates = block.get_all_dates
    rooms = calendar.list_available_rooms(block)
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

end
