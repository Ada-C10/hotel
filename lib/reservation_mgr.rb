require 'pry'
require_relative 'room'
require_relative 'reservation'

class ReservationMgr
  attr_reader :rooms , :reservations
  def initialize(num_rooms)
    @rooms = Room.create(num_rooms)
    @reservations = []

  end

  def make_reservation(check_in,check_out,rooms: 1, block: nil)

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
        available_rooms << room.id
      end
    end

    if available_rooms.length == 0 || available_rooms.length < rooms
      raise ArgumentError.new('There are not enough room/rooms available')
    end

    i = 0
    rooms.times do |room|
      @reservations << Reservation.new(check_in,check_out,available_rooms[i])
      update_room = @rooms.find {|room| room.id == available_rooms[i]}
      update_room.add_unavailable_dates(check_in,check_out)
      i + 1
    end
    new_res = @reservations.length-1
    return @reservations[(new_res-rooms)..new_res]
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

end
