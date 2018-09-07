class BookingManager
  attr_reader :calendar
  def initialize(calendar)
    @calendar = calendar
  end

  def print_all_rooms
    return calendar.room_assignments.keys
  end

  def reservation_list(date)
    reservations = []
    room_assignments = calendar.room_assignments
    room_assignments.each do |k, v|
      if v.include? (Date.parse(date))
        reservations << k
      end
    end
    return reservations
  end

  def print_available_rooms(check_in, check_out)
    request = Reservation.new(check_in, check_out)
    return calendar.list_available_rooms(request)
  end



end
