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



end
