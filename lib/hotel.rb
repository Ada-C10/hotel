require 'date'
class Hotel
  attr_reader :reservations, :rooms
  # attr_accessor
  def initialize(reservations = [], rooms = [])
    @reservations = reservations # array of hashes that are instance of reservations
    @rooms = generate_rooms  # array of hashes that are instance of room
    # @block_reservations = lock_reservations # array of hashes that are instance of block reservations
  end

  def make_reservation(check_in = Date.new(check_in), check_out = Date.new(check_out))
    # reserve_room
    # check_in = Date.new(check_in)
    # check_out = Date.new(check_out)
    room = reserve_room

    reservation = Reservation.new(check_in, check_out, room)
    @reservations << reservation
    return reservation
  end

  def generate_rooms
    rooms = []
    room_number = 1
    until room_number == 21
      rooms << Room.new(room_number)
      room_number += 1
    end

    return rooms
  end

  def list_reservations
    # returns reservarions
  end

  def list_rooms_available(start_date, end_date)

    @rooms.each do |room|
      if  room.dates
       # room.dates.include?(start_date)
    end
  end

  def find_reservation(date)
    @reservations.each do |reservation|
      if reservation.check_in == date
        return reservation
      end
    end
  end
 # compare directly to dates not status of room.

  # def find_available_rooms(check_in_search, check_out_search)
  #   @reservations.each do |reservation|
  #     # (reservation.check_in..reservation.check_out) == (check_in..check_out) ||
  #      if reservation.check_out <= check_in_search
  #        return reservation.room
  #      end
  #   end
  # end


  def reserve_room # helper method
    @rooms.each do |room|
      if room.status == :available
        room.status = :reserved
        reserved_room = room
        room.dates << reserved_room
        return reserved_room
      end
    end

    # changes room status with helper method
  end

  # def reserve_block
  # end

  # def cancel_reservations
  # end

end
