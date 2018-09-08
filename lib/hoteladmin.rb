class HotelAdmin
  attr_reader :rooms, :reservations

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
    reservations.select { |res| res.date_range.include? date }
  end

  def reserve_room(reservation_details)
    new_reservation = retrieve_room(reservation_details[:room]).add_booking(Reservation.new(reservation_details))
    reservations << new_reservation
    new_reservation
  end

  def build_reservation(guest_identifier, room_number, check_in, check_out, rate = 200.00, status = :complete)
    reserve_room({
      guest_id: guest_identifier,
      room: room_number,
      date_range: (check_in...check_out),
      rate: rate,
      status: status
    })
  end

  def reservation_charge(reservation)
    reservation.stay_cost
  end

  def available_rooms(check_in, check_out)
    rooms.find_all {|room| room.available?((check_in..check_out))}
  end

  def locate_block(check_in, check_out)
    available_rooms =[]
    rooms.each do |room|
      return available_rooms if available_rooms.length == 5
        available_rooms << room if room.available?((check_in..check_out))
    end
  end

  def reserve_block(party, rooms, check_in, check_out, rate)
    raise ArgumentError, ("There is a limit of 5 rooms to a block") if rooms.length > 5
    block_reservations = []
    rooms.each do |room_number|
      block_reservations << build_reservation(party, room_number, check_in, check_out, rate, status = :block_reserved)
    end
    block_reservations
  end

  def reserve_room_in_block(party, room_number)
    retrieve_room(room_number).bookings.find {|res| res.guest_id == party}.complete_reservation
  end

  def available_rooms_in_block(party)
    reservations.find_all {|res| res.guest_id == party && res.status == :block_reserved}.map {|res| res.room}
  end

end
