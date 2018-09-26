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
      rooms << i + 1
    end
    return rooms
  end

  def list_rooms
    return rooms
  end

  def reserve_room(reservation)

    reservations << reservation

    reservation.number_of_rooms.times do
      reserved_room = find_available_room(reservation.start_date, reservation.end_date)
      reservation.add_rooms_reserved(reserved_room)
    end

  end

  def find_available_room(start_d, end_d)
    reserved_rooms = rooms_not_available(start_d, end_d)
    return rooms[0] if reserved_rooms.nil?

    rooms.each do |room|
      return room if !(reserved_rooms.include? room)
      #if the room is NOT one of the reserved_rooms
    end

    raise ArgumentError, "Not enough or no available rooms!"
  end

  def rooms_not_available(start_date, end_date)
    not_available_rooms = []

    reservations.each do |reservation|
      not_available_rooms << reservation.rooms if reservation.dates_overlap?(start_date, end_date)
    end

    room_blocks.each do |room_block|
      if room_block.dates_overlap?(start_date, end_date)
        not_available_rooms << room_block.rooms_reserved
        not_available_rooms << room_block.rooms_blocked
      end
    end

    return not_available_rooms.flatten!
  end

  def list_reservations(date)
    list = []
    @reservations.each do |reservation|
      if reservation.start_date == Date.parse(date)
        list << reservation
      end
    end
    return list
  end

  def reservation_cost(res_id)
    @reservations.each do |reservation|
      return reservation.cost if reservation.id == res_id
    end
    raise ArgumentError, "No such reservation."
  end

  def list_available_rooms(start_d, end_d)
    unavailable_rooms = rooms_not_available(Date.parse(start_d), Date.parse(end_d))
    available_rooms = []

    if unavailable_rooms.nil?
      return list_rooms
    elsif unavailable_rooms.length == rooms.length
      return "All rooms are reserved from #{start_d} to #{end_d}."
    else
      rooms.each do |room|
        available_rooms << room if !(unavailable_rooms.include? room)
      end
    end
    return available_rooms
  end

  def create_room_block(new_block)

    raise ArgumentError, "You can only book up to 5 rooms." if new_block.number_of_rooms > 5

    room_blocks << new_block

    new_block.number_of_rooms.times do
      blocked_room = find_available_room(new_block.start_date, new_block.end_date)
      new_block.add_rooms_blocked(blocked_room)
      #add the blocked room to the new block booking
    end

  end

  def list_available_block_rooms(block_booking_id)
    block_booking = find_block_booking(block_booking_id)
    return block_booking.rooms_blocked
  end

  def find_block_booking(block_booking_id)
    @room_blocks.each do |block_booking|
      return block_booking if block_booking.id == block_booking_id
    end
    raise ArgumentError, "No such block booking."
  end

  def reserve_block_room(block_booking_id, number_of_rooms)

    block_booking = find_block_booking(block_booking_id)

    new_reservation = Reservation.new(block_booking.start_date.to_s, block_booking.end_date.to_s, number_of_rooms, block_booking.discounted_rate)
    reservations << new_reservation

    number_of_rooms.times do
      new_reservation.add_rooms_reserved(block_booking.rooms_blocked[0])
      block_booking.add_rooms_reserved(block_booking.rooms_blocked[0])
      block_booking.rooms_blocked.delete(block_booking.rooms_blocked[0])
    end
  end

end
