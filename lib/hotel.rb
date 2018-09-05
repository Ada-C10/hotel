require_relative 'room'
require 'date'
require 'pry'

class Hotel
  attr_reader :reservations, :rooms

  def initialize(num, reservations = [])
    @rooms = load_rooms(num)
    @reservations = reservations
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

#make two methods for groups and individuals

    new_reservation = Reservation.new(start_date, end_date)
    reservations << new_reservation

    if number_of_rooms > 1
      number_of_rooms.times do
        reserved_room = find_available_room(start_date, end_date)
        new_reservation.add_rooms_reserved(reserved_room)
        reserved_room.add_reservations(new_reservation)
      end
    elsif number_of_rooms == 1
      reserved_room = find_available_room(start_date, end_date)
      new_reservation.add_rooms_reserved(reserved_room)
      reserved_room.add_reservations(new_reservation)
    end
  end

  def find_available_room(start_d, end_d)
    # find_rooms_without_reservations #returns rooms_without_reservations
    rooms.each do |room|
      if !(not_available_rooms(start_d, end_d).include? room)
        #if the room is NOT one of the not_available_rooms 
        return room
      end
    end
    raise ArgumentError, "No available rooms."
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
    reservations.each do |reservation|
      if (Date.parse(start_d) <= reservation.end_date) && (Date.parse(end_d) >= reservation.start_date)
        not_available_rooms << reservation.rooms
      end
    end
    return not_available_rooms.flatten!
  end

  def find_rooms_without_reservations
    rooms.each do |room|
      return room if room.reservations.length == 0
    end
  end

end
