require 'date'
require 'pry'
require_relative 'reservation'
require_relative 'dates'

class ReservationTracker
  attr_reader :rooms, :all_reservations, :cost


  def initialize
    @all_reservations = []
    @rooms = Room.new
    @all_blocks = []
    @block_room_reservations = []
  end


  def new_reservation(date_range)
    date_range = Dates::date_range_format(date_range)

    room_num = @rooms.find_available_room(occupied_rooms(date_range))

    rate = @rooms.rate

    reservation = Reservation.new(date_range, room_num, rate)
    @all_reservations << reservation
    return reservation
  end


  def reservation_list_by_date(date)
    date = Dates::date_format(date)

    reservation_list_by_date = @all_reservations.find_all { |reservation|
      date >= reservation.date_range[:begin_date] && date < reservation.date_range[:end_date] }
    return reservation_list_by_date
  end


  def occupied_rooms(date_range)
    occupied_rooms = []
    date_range = Dates::date_range_format(date_range)
    @all_reservations.each do |reservation|
      if Dates::date_range_comparison(date_range, reservation.date_range)
        if reservation.room_num.class == Array
          reservation.room_num.each do |num| occupied_rooms << num
          end
        else
          occupied_rooms << reservation.room_num
        end
      end
    end
    return occupied_rooms
  end


  def reserve_block(date_range, num_rooms, discount_rate)
    raise ArgumentError, "5 room limit for blocks" if num_rooms > 5
    date_range = Dates::date_range_format(date_range)

    room_block = @rooms.find_block_of_rooms(num_rooms, occupied_rooms(date_range))

    reservation = Reservation.new(date_range, room_block, discount_rate)

    @all_blocks << reservation
    @all_reservations << reservation
    return reservation
  end


  def occupied_block_rooms(date_range)
    used_block_rooms = []
    date_range = Dates::date_range_format(date_range)
    reservations = @block_room_reservations.find_all { |reservation| reservation.date_range == date_range }
    occupied_block_rooms = reservations.map { |reservation| used_block_rooms << reservation.room_num }
    return used_block_rooms
  end


  def open_rooms_in_block(date_range)
    date_range = Dates::date_range_format(date_range)
    block = @all_blocks.find{ |block| block.date_range == date_range }
    block_rooms = block.room_num
    open_rooms = block_rooms - occupied_block_rooms(date_range)
    return open_rooms
  end

  def first_available_block_room(date_range)
    rooms = open_rooms_in_block(date_range)
    return rooms.first
  end


  def new_block_room_reservation(date_range)
    date_range = Dates::date_range_format(date_range)

    room_num = first_available_block_room(date_range)

    rate = (@all_blocks.find{ |block| block.date_range == date_range }).rate

    reservation = Reservation.new(date_range, room_num, rate)
    @all_reservations << reservation
    @block_room_reservations << reservation
    return reservation
  end
end
