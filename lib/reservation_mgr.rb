require 'pry'
require_relative 'room'
require_relative 'reservation'

class ReservationMgr
  attr_reader :rooms , :reservations
  def initialize(num_rooms)
    @rooms = Room.create(num_rooms)
    @reservations = []

  end

  def available_rooms(check_in,check_out)
    if check_in.class != Date
      check_in = Date.parse(check_in)
    end
    if check_out.class != Date
      check_out = Date.parse(check_out)
    end
    if check_out < check_in
      raise ArgumentError.new('The check-out date is before the check-in')
    end

    available_rooms = []
    @rooms.each do |room|
      if room.is_available?(check_in,check_out)
        available_rooms << room
      end
    end
    return available_rooms
  end

  def make_reservation(check_in,check_out,rooms: 1, block: nil)

    if check_in.class != Date
      check_in = Date.parse(check_in)
    end
    if check_out.class != Date
      check_out = Date.parse(check_out)
    end

    available_rooms = available_rooms(check_in,check_out)

    if available_rooms.length == 0 || available_rooms.length < rooms
      raise ArgumentError.new('There are not enough room/rooms available')
    end

    i = 0
    rooms.times do |room|
      @reservations << Reservation.new(check_in,check_out,available_rooms[i].id)
      update_room(check_in,check_out,available_rooms[i].id)
      i + 1
    end
    new_res = @reservations.length-1
    return @reservations[(new_res-rooms)..new_res]
  end

  def update_room(check_in,check_out,room_num)
    update_room = @rooms.find {|room| room.id == room_num}
    update_room.add_unavailablity(check_in,check_out)
  end

  def reservations_by_date(date)
    reservations_on_date = []
    @reservations.each do |reservation|
      if reservation.date?(date)
        reservations_on_date << reservation
      end
    end

    return reservations_on_date

  end

  def reservation_cost(reservation)
    reservation.cost
  end

  def reserve_block(check_in,check_out,rooms: 1, block: nil)

  end

end
