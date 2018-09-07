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
    #change because of date range use?
    reservations.select { |res| res.date_range.include? date }
  end

  #This method does too much!
  def reserve_room(guest_identifier, room_number, check_in, check_out, rate = 200.00, status = nil)
    new_reservation = Reservation.new({
      guest_id: guest_identifier, room: room_number, date_range: (check_in..check_out), rate: rate, status: status
    })
    room_object = retrieve_room(room_number)
    room_object.add_booking(new_reservation)
    reservations << new_reservation
    new_reservation
  end

  def reservation_charge(reservation)
    reservation.cost
  end

  def available_rooms(check_in, check_out)
    rooms.select do |room|
      room.available?((check_in..check_out))
    end
  end

  def locate_block(check_in, check_out)
    available =[]
    rooms.each do |room|
      return available if available.length == 5
        available << room if room.available?((check_in..check_out))
    end
  end

  def reserve_block(party, rooms_array, check_in, check_out, rate)
    block_reservations = []
    rooms_array.each do |room_number|
      block_reservations << reserve_room(party, room_number, check_in, check_out, rate, status = :block_reserved)
    end
    block_reservations
  end

end
