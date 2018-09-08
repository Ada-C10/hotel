class Calendar

  # ROOMS = [*1..20]

  attr_reader :rooms, :room_assignments

  def initialize
    @rooms = [*1..20]
    @room_assignments = Hash[ @rooms.collect { |room| [room, []] } ]
  end

  def available_room?(room, reservation)
    dates = reservation.get_all_dates
    if dates.any? { |date| @room_assignments[room].include? (date)}
      return false
    end

    return true
  end

  def list_available_rooms(reservation)
    available_rooms = rooms.select { |room| available_room?(room, reservation)}
  end

  def add_reservation(reservation)
    dates = reservation.get_all_dates
    room = list_available_rooms(reservation).first
    dates.each do |date|
      @room_assignments[room] << date
    end

    return "Added!"
  end

end
