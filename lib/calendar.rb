require_relative 'block'
require_relative 'booking_manager'
class Calendar

  attr_reader :rooms, :room_assignments

  def initialize(number_of_rooms)
    @rooms = [*1..(number_of_rooms)]
    @room_assignments = Hash[ @rooms.collect { |room| [room, []] } ]
  end

  def reservation_list(date)
    # room_assignments = calendar.room_assignments
    date = Date.parse(date)
    reservations = room_assignments.select { |room, dates|  dates.include? (date) }.keys
  end

  def available_room?(room, reservation)
    dates = reservation.get_all_dates
    if dates.any? { |date| room_assignments[room].flatten.include? (date)}
      return false
    end

    return true
  end

  def list_available_rooms(reservation)
    available_rooms = rooms.select { |room| available_room?(room, reservation)}
  end

  # def available_block_rooms(block)
  #   rooms = block.rooms.keys
  #   available_rooms = rooms.select { |room| available_room?(room, block)}
  # end

  def reserve_block_room(block)
    block.rooms.each do |k, v|
      if v == :available
        block.rooms[k] = :unavailable
        return k
      end
    end
  end

end
