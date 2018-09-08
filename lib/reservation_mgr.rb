require 'pry'
require 'date'
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

  def make_reservation(check_in,check_out,rooms: 1, block_id: nil)

    if check_in.class != Date
      check_in = Date.parse(check_in)
    end
    if check_out.class != Date
      check_out = Date.parse(check_out)
    end
    if block_id == nil
      available_rooms = available_rooms(check_in,check_out)

      if available_rooms.length == 0 || available_rooms.length < rooms
        raise ArgumentError.new('There are not enough room/rooms available')
      end

      i = 0
      new_reservations = []
      rooms.times do |room|
        new_reservation = Reservation.new(check_in,check_out,available_rooms[i].id, block_id: block_id)
        @reservations << new_reservation
        new_reservations << new_reservation
        update_room(check_in,check_out,available_rooms[i].id)
        i + 1
      end

      return new_reservations

    else
      block_rooms = find_available_block_rooms(block_id)

      if check_in != block_rooms[0].check_in || check_out != block_rooms[0].check_out
        raise ArgumentError.new('The dates do not match for this given block reservation')

      end

      rooms.times do |index|
        block_rooms[index].block_available = false
      end

      return block_rooms[0...rooms]
    end

  end

  def update_room(check_in,check_out,room_num,block_id: block_id)
    update_room = @rooms.find {|room| room.id == room_num}
    update_room.add_unavailablity(check_in,check_out,block_id: block_id)
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

  def reserve_block(check_in,check_out, rooms, block_id)
    if rooms > 5
      raise ArgumentError.new('You cannot block more than 5 rooms')
    end

    available_rooms = available_rooms(check_in,check_out)

    if available_rooms.length == 0 || available_rooms.length < rooms
      raise ArgumentError.new('There are not enough room/rooms available')
    end

    i = 0
    new_reservations = []
    rooms.times do |room|
      new_reservation = Reservation.new(check_in,check_out,available_rooms[i].id, block_id: block_id)
      @reservations << new_reservation
      new_reservations << new_reservation
      update_room(check_in,check_out,available_rooms[i].id, block_id: block_id)
      i + 1
    end

    return new_reservations
  end

  def find_available_block_rooms(block_id)
    block_rooms = @reservations.select { |reservation|  reservation.block_id == block_id && reservation.block_available == true  }
    if block_rooms.length == 0
      raise ArgumentError.new("No available rooms in the block")
    else
      return block_rooms
    end
  end


end



# new_ResMgr = ReservationMgr.new(6)
# new_ResMgr.make_reservation(Date.parse("2018-09-05"),Date.parse("2018-09-07"))
# block1 = new_ResMgr.reserve_block(Date.parse("2018-09-05"),Date.parse("2018-09-07"),2,"Dysinger")
# puts block1
# binding.pry
# new_ResMgr.make_reservation(Date.parse("2018-09-05"),Date.parse("2018-09-07"))
# new_ResMgr.reserve_block(Date.parse("2018-09-05"),Date.parse("2018-09-07"),4,"Metzner")
