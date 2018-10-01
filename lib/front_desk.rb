require_relative "rooms.rb"
require_relative "reservations.rb"


class Front_Desk

  attr_reader :reservations, :rooms, :block_hold

  def initialize
    @reservations = []
    @block_reservations = []
    @rooms = load_rooms
  end

  def load_rooms
    room_number = 0
    rooms = []

    20.times do
      room_number += 1
      rooms << Room.new({
        :room_number => room_number
      })
    end
    return rooms
  end

  def reserve_room(room_number, start_date, end_date)
    if start_date > end_date
      raise StandardError.new("Checkin Date: #{start_date} must be before Checkout Date: #{end_date}")
    end

    available_rooms = available_rooms(start_date,end_date)
    if !available_rooms.find { |room| room.room_number == room_number }
      raise AlreadyReservedError.new("Room #{room} already has a reservation between #{start_date} and #{end_date}")
    end

    input = {}
    input[:room_number] = room_number
    input[:start_date] = start_date
    input[:end_date] = end_date

    new_reservation = Reservation.new(input)
    @reservations << new_reservation

    return new_reservation
  end

  #method to grab reservation by Date
  def search_reserved_by_date(search_date)
    search_date = Date.parse(search_date)
    results = []

    @reservations.each do |reservation|
      if reservation.start_date <= search_date && search_date < reservation.end_date
        results << @reservations
      end
    end

    @block_reservations.each do |reservation|
      if reservation.start_date <= search_date && search_date < reservation.end_date
        results << @block_reservations
      end
    end

    return results
  end

  def available_rooms(start_date,end_date)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)

    list_of_rooms = @rooms.dup

    @reservations.each do |reservation|
      if !((start_date < reservation.start_date && end_date <= reservation.start_date) ||
        (end_date > reservation.end_date && start_date >= reservation.end_date))
        list_of_rooms.reject! { |room| room.room_number == reservation.room_number }
      end
    end

    @block_reservations.each do |block_room|
      if !((start_date < block_room.start_date && end_date <= block_room.start_date) ||
        (end_date > block_room.end_date && start_date >= block_room.end_date))
        list_of_rooms.reject! { |room| room.room_number == block_room.room_number }
      end
    end

    return list_of_rooms
  end


  def block_hold(start_date, end_date, number_of_rooms)
    available_rooms = available_rooms(start_date,end_date)

    if start_date > end_date
      raise StandardError.new("Checkin Date: #{start_date} must be before Checkout Date: #{end_date}")
    elsif number_of_rooms > 5
      raise StandardError
    end

    number_of_rooms.times do |index|
      input = {}
      input[:room_number] = available_rooms[index].room_number
      input[:start_date] = start_date
      input[:end_date] = end_date

      block_hold = Reservation.new(input)
      @block_reservations << block_hold

    end
    return @block_reservations
  end


end
