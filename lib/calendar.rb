class Calendar

  attr_reader :rooms, :room_assignments

  def initialize(number_of_rooms)
    @rooms = [*1..(number_of_rooms)]
    @room_assignments = Hash[ @rooms.collect { |room| [room, []] } ]
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
