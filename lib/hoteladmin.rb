class HotelAdmin
  attr_accessor :rooms, :reservations

  def initialize
    @rooms = []
    @reservations = []
  end

  def list_rooms
    rooms
  end

  def retrieve_by_date(date)
    raise ArgumentError, "Valid date format was not provided." if date.class != Date
    reservations.select { |res| (res.date_range.first..res.date_range.last).include? date }
  end

  def reserve_room(guest_email, room_number, check_in, check_out)
    new_reservation = Reservation.new({guest_id: guest_email, room_id: room_number, date_range: [check_in, check_out]})
    reservations << new_reservation
    new_reservation
  end

end
