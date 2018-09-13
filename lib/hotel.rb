require 'date'
class Hotel
  attr_reader :reservations, :rooms
  # attr_accessor
  def initialize(reservations = [], rooms = [])
    @reservations = reservations
    @rooms = generate_rooms
    # @block_reservations = lock_reservations
  end

  def make_reservation(check_in = Date.new(check_in), check_out = Date.new(check_out))
    room = @rooms.select do
      |room| room.available?(check_in, check_out)
     end
    room = room.first

    reservation = Reservation.new(check_in, check_out, room)
    @reservations << reservation
    room.reserve(reservation)
    return reservation
  end

  def generate_rooms
    rooms = 20.times.map do |number|
      Room.new(number)
    end
    return rooms
  end

  def rooms_available(check_in, check_out)
    @rooms.each do |room|
      room.available?(check_in, check_out)
    end
  end

  def find_reservation(check_out, check_in)
    @reservations.each do |reservation|
      return reservation if reservation.during?(check_out, check_in)
      return "Reservation not found"
    end
  end

  # def reserve_room # helper method
  #   @rooms.each do |room|
  #
  #     available?
  #     if room.status == :available
  #       room.status = :reserved
  #       reserved_room = room
  #       room.dates << reserved_room
  #       return reserved_room
  #     end
  #   end
  #
  #   # changes room status with helper method
  # end

  # def reserve_block
  # end

  # def cancel_reservations
  # end

end
