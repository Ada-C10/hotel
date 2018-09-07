require_relative 'room'
require_relative 'reservation'
require_relative 'block_reservation'

require 'date'
require 'pry'

class Hotel
  attr_reader :reservations, :rooms, :block_reservations

  def initialize(num)
    @rooms = load_rooms(num)
    @reservations = []
    @block_reservations = []
  end

  def load_rooms(number)
    rooms = []
    number.times do |i|
      rooms << Room.new((i + 1), 200)
    end
    return rooms
  end

  def list_rooms
    rooms.each do |room|
      room
    end
  end

  def reserve_room(start_date, end_date, number_of_rooms)

    #create a room check method to call here so that an error will happen if all rooms aren't available

    new_reservation = Reservation.new(start_date, end_date, number_of_rooms)
    reservations << new_reservation

    number_of_rooms.times do
      reserved_room = find_available_room(start_date, end_date)
      new_reservation.add_rooms_reserved(reserved_room)
      reserved_room.add_reservations(new_reservation)
    end

  end

  def find_available_room(start_d, end_d)
    return rooms[0] if not_available_rooms(start_d, end_d).nil?

    rooms.each do |room|
      if !(not_available_rooms(start_d, end_d).include? room)
        #if the room is NOT one of the not_available_rooms
        return room
      end
    end

    raise ArgumentError, "Not enough or no available rooms!"
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
      if reservation.reservation_id == res_id
        return reservation.cost
      end
    end
    raise ArgumentError, "No such reservation."
  end

  def not_available_rooms(start_d, end_d)
    not_available_rooms = []
    return not_available_rooms if reservations.nil? && block_reservation.nil?

    if !(reservations.nil?) #if reservations is not nil
      reservations.each do |reservation|
        if (Date.parse(start_d) <= reservation.checkout_date) && (Date.parse(end_d) > reservation.start_date)
          not_available_rooms << reservation.rooms
        end
      end
    end

    if !(block_reservations.nil?) #if block_reservations is not nil
      block_reservations.each do |block_reservation|
        if (Date.parse(start_d) <= block_reservation.checkout_date) && (Date.parse(end_d) > block_reservation.start_date)
          not_available_rooms << block_reservation.rooms_reserved
          not_available_rooms << block_reservation.rooms_blocked
        end
      end
    end
    return not_available_rooms.flatten!
  end


  def list_available_rooms(start_d, end_d)
    rooms_without_reservations = []

    if not_available_rooms(start_d, end_d).nil?
      return rooms
    elsif not_available_rooms(start_d, end_d).length == rooms.length
      return "All rooms are reserved from #{start_d} to #{end_d}."
    else
      rooms.each do |room|
        if !(not_available_rooms(start_d, end_d).include? room)
          rooms_without_reservations << room
        end
      end
      return rooms_without_reservations
    end
  end

  def reserve_room_block(start_d, end_d, number_of_rooms, discounted_rate)
    raise ArgumentError, "You can only reserve up to 5 rooms." if number_of_rooms > 5

    new_block_reservation = BlockReservation.new(start_d, end_d, number_of_rooms, discounted_rate)

    block_reservations << new_block_reservation

    number_of_rooms.times do
      blocked_room = find_available_room(start_d, end_d)

      new_block_reservation.add_rooms_blocked(blocked_room)
      #add the blocked room to the new block reservation
      blocked_room.add_block_reservations(new_block_reservation)
      #add the new block reservation to the blocked room
    end
  end

  def list_available_block_rooms(block_reservation_id)
    block_reservation = find_block_reservation(block_reservation_id)
    return block_reservation.rooms_blocked
  end


  def find_block_reservation(block_reservation_id)
    @block_reservations.each do |block_reservation|
      return block_reservation if block_reservation.reservation_id == block_reservation_id
    end
    raise ArgumentError, "No such block reservation."
  end

  def reserve_block_room(block_reservation_id, number_of_rooms)

    block_reservation = find_block_reservation(block_reservation_id)

    i = 0
    until i == number_of_rooms
      block_reservation.add_rooms_reserved(block_reservation.rooms_blocked[0])
      block_reservation.rooms_blocked.delete(block_reservation.rooms_blocked[0])
      i += 1
    end
  end

end
