class HotelAdmin
  attr_accessor :rooms, :reservations

  def initialize
    @rooms = build_rooms
    @reservations = []
  end

  def build_rooms
    room_set = []
    20.times do |i|
      room_set << Room.new(i+1)
    end
    room_set
  end

  def list_rooms
    rooms
  end

  def retrieve_room(number)
    rooms.find {|r| r.room_id == number}
  end

  def retrieve_by_date(date)
    raise ArgumentError, "Valid date format was not provided." if date.class != Date
    reservations.select { |res| (res.date_range.first..res.date_range.last).include? date }
  end

  def reserve_room(guest_email, room_number, check_in, check_out)
    new_reservation = Reservation.new({guest_id: guest_email, room_id: room_number, date_range: [check_in, check_out]})
    reservations << new_reservation
    #add_booking
    new_reservation
  end

  def reservation_charge(reservation)
    reservation.cost
  end



end
