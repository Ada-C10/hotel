require_relative 'room'
require_relative 'reservation'
require_relative 'blockrooms'

require 'date'
require 'pry'

class Hotel
  attr_reader :reservations, :rooms, :room_blocks

  def initialize(num)
    @rooms = load_rooms(num)
    @reservations = []
    @room_blocks = []
  end

  def load_rooms(number)
    rooms = []
    number.times do |i|
      rooms << Room.new(i + 1)
    end
    return rooms
  end

  def list_rooms
    rooms.each do |room|
      room
    end
  end

  def reserve_room(start_date, end_date, number_of_rooms)

    new_reservation = Reservation.new(start_date, end_date, number_of_rooms)
    reservations << new_reservation

    number_of_rooms.times do
      reserved_room = find_available_room(start_date, end_date)
      new_reservation.add_rooms_reserved(reserved_room)
      reserved_room.add_reservations(new_reservation)
    end

  end

  def find_available_room(start_d, end_d)
    return rooms[0] if rooms_not_available(start_d, end_d).nil?

    rooms.each do |room|
      return room if !(rooms_not_available(start_d, end_d).include? room)
      #if the room is NOT one of the not_available_rooms
    end

    raise ArgumentError, "Not enough or no available rooms!"
  end

  def list_reservations(date)
    list = []
    @reservations.each do |reservation|
      list << reservation if reservation.start_date == Date.parse(date)
    end
    return list
  end

  def reservation_cost(res_id)
    @reservations.each do |reservation|
      return reservation.cost if reservation.reservation_id == res_id
    end
    raise ArgumentError, "No such reservation."
  end

  def rooms_not_available(start_date, end_date)
    not_available_rooms = []

    reservations.each do |reservation|
      not_available_rooms << reservation.rooms if dates_overlap?(start_date, end_date, reservation.start_date, reservation.checkout_date)
    end

    room_blocks.each do |room_block|
      if dates_overlap?(start_date, end_date, room_block.start_date, room_block.checkout_date)
        not_available_rooms << room_block.rooms_reserved
        not_available_rooms << room_block.rooms_blocked
      end
    end

    return not_available_rooms.flatten!
  end

  def dates_overlap?(start_a, end_a, start_b, end_b)
    (Date.parse(start_a) <= end_b) && (Date.parse(end_a) > start_b)
  end

  def list_available_rooms(start_d, end_d)
    rooms_without_reservations = []

    if rooms_not_available(start_d, end_d).nil?
      return rooms
    elsif rooms_not_available(start_d, end_d).length == rooms.length
      return "All rooms are reserved from #{start_d} to #{end_d}."
    else
      rooms.each do |room|
        if !(rooms_not_available(start_d, end_d).include? room)
          rooms_without_reservations << room
        end
      end
      return rooms_without_reservations
    end
  end

  def create_room_block(start_d, end_d, number_of_rooms, discounted_rate)
    raise ArgumentError, "You can only book up to 5 rooms." if number_of_rooms > 5

    new_block = BlockRooms.new(start_d, end_d, number_of_rooms, discounted_rate)
    room_blocks << new_block

    number_of_rooms.times do
      blocked_room = find_available_room(start_d, end_d)
      new_block.add_rooms_blocked(blocked_room)
      #add the blocked room to the new block booking
      blocked_room.add_block(new_block)
      #add the new block booking to the blocked room
    end

  end

  def list_available_block_rooms(block_booking_id)
    block_booking = find_block_booking(block_booking_id)
    return block_booking.rooms_blocked
  end


  def find_block_booking(block_booking_id)
    @room_blocks.each do |block_booking|
      return block_booking if block_booking.block_id == block_booking_id
    end
    raise ArgumentError, "No such block booking."
  end

  def reserve_block_room(block_booking_id, number_of_rooms)

    block_booking = find_block_booking(block_booking_id)

    number_of_rooms.times do
      new_reservation = Reservation.new(block_booking.start_date.to_s, block_booking.end_date.to_s, number_of_rooms, block_booking.discounted_rate)
      reservations << new_reservation

      new_reservation.add_rooms_reserved(block_booking.rooms_blocked[0])
      block_booking.rooms_blocked[0].add_reservations(new_reservation)

      block_booking.add_rooms_reserved(block_booking.rooms_blocked[0])
      block_booking.rooms_blocked.delete(block_booking.rooms_blocked[0])
    end
  end

end
