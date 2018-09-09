class BookingManager

  attr_reader :calendar

  def initialize(calendar)
    @calendar = calendar
  end

  def reservation_list(date)
    room_assignments = calendar.room_assignments
    date = Date.parse(date)
    reservations = room_assignments.select { |room, dates|  dates.include? (date) }.keys
  end

  def print_available_rooms(check_in, check_out)
    request = Reservation.new(check_in, check_out)
    return calendar.list_available_rooms(request)
  end

end
