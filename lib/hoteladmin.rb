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
    rooms.find {|r| r.id == number}
  end

  def retrieve_by_date(date)
    raise ArgumentError, "Valid date format was not provided." if date.class != Date
    reservations.select { |res| (res.date_range.first..res.date_range.last).include? date }
  end

  #This method does too much!
  def reserve_room(guest_email, room_number, check_in, check_out)
    room_object = retrieve_room(room_number)
    new_reservation = Reservation.new({guest_id: guest_email, room: room_object, date_range: [check_in, check_out]})
    room_object.add_booking(new_reservation)
    reservations << new_reservation
    new_reservation
  end

  def reservation_charge(reservation)
    reservation.cost
  end

  def available_rooms(check_in, check_out)
    rooms.select do |room|
      room.available?(check_in, check_out)
    end
  end

end
