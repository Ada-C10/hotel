require 'date'
class ReservationManager
  attr_reader :reservations, :rooms
  # attr_accessor
  def initialize(reservations = [], rooms = [])
    @reservations = reservations
    @rooms = generate_rooms
    # @block_reservations = block_reservations
  end

  def generate_rooms
    rooms = 20.times.map do |number|
      Room.new(number)
    end
    return rooms
  end

  def make_reservation(check_in = Date.new(check_in), check_out = Date.new(check_out))
    room = rooms_available(check_in, check_out).first
    reservation = Reservation.new(check_in, check_out, room)
    @reservations << reservation
    room.reserve(reservation)
    return reservation
  end

  def rooms_available(check_in, check_out)
   free_rooms = @rooms.select do |room|
      room.available?(check_in, check_out)
    end
    return free_rooms
  end

# rethinking design
# def rooms_available(check_in, check_out)
#  free_rooms = @rooms.select do |room|
#     room.room_availble?(check_in, check_out)
#   end
#   return free_rooms
# end

  def find_reservation(check_out, check_in)
    @reservations.each do |reservation|
      return reservation if reservation.during?(check_out, check_in)
      return "Reservation not found"
    end
  end

  # def list_reservations(check_out, check_in)
  # end

  # def reserve_block
  # end

  # def cancel_reservations
  # end

end
