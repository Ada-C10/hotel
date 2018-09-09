require 'date'
require 'pry'
require_relative 'reservation'
require_relative 'dates'

class ReservationTracker
  attr_reader :rooms, :all_reservations, :cost


  def initialize
    @all_reservations = []
    @rooms = Room.new
    @block_reservations = []
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
    date_range = Dates::date_range_format(date_range)

    room_block = @rooms.find_block_of_rooms(num_rooms, occupied_rooms(date_range))

    reservation = Reservation.new(date_range, room_block, discount_rate)

    @block_reservations << reservation
    @all_reservations << reservation
    return reservation
  end
end
