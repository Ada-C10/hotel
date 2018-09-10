require 'date'
require_relative 'date_logic'
require_relative 'reservation'

require 'pry'

module BookingLogic
  class RoomBooker
    attr_reader :rooms
    attr_accessor :reservations, :blocks

    def initialize
      @rooms = populate_rooms
      @reservations = []
      @blocks = []
    end

    Room = Struct.new(:id, :cost)

    def populate_rooms
      rooms_array = []

      20.times do |id|
        room = Room.new((id + 1), 200)
        rooms_array << room
      end

      return rooms_array
    end

    def list_rooms
      return rooms
    end

    def find_room_by_id(room_id)
      return rooms.find { |room| room.id == room_id }
    end

    def new_reservation(room_id, check_in, check_out)
      room = find_room_by_id(room_id)
      new_reservation = BookingLogic::Reservation.new(room, check_in, check_out)
      reservations << new_reservation
      return new_reservation
    end

    # def date_range_include?(reservation, date)
    #   if (reservation.check_in..reservation.check_out).cover?(date)
    #     return true
    #   else
    #     return false
    #   end
    # end

    def list_reservations(date)
      list_of_reservations = []

      reservations.each do |reservation|
        if DateLogic.date_range_include?(reservation, date)
          list_of_reservations << reservation
        end
      end

      return list_of_reservations
    end

    def find_reservation(room_id, check_in)
      reservations.each do |reservation|
        if reservation.room.id == room_id && reservation.check_in == check_in
          return reservation
        end
      end
    end

    # def reservation_cost(room_id, check_in)
    #   reservation = find_reservation(room_id, check_in)
    #   days_reserved = reservation.check_out - reservation.check_in
    #   return days_reserved.to_i * reservation.room.cost
    # end

    # def create_date_range_array(check_in, check_out)
    #   date_range_array = check_in...check_out
    #   return date_range_array.to_a
    # end

    # def date_ranges_exclusive?(
    #   existing_reservation,
    #   new_check_in,
    #   new_check_out)
    #
    #   existing_range_array = existing_reservation.date_range_array
    #   new_range_array = new_reservation.date_range_array
    #
    #   intersecting_dates = existing_range_array & new_range_array
    #
    #   if intersecting_dates.empty?
    #     return true
    #   else
    #     return false
    #   end
    # end



    def list_available_rooms(check_in, check_out)
      reserved_rooms = []

      reservations.each do |reservation|
        unless DateLogic.date_ranges_exclusive?(reservation, check_in, check_out)
          reserved_rooms << reservation.room
        end
      end

      available_rooms = rooms - reserved_rooms

      return available_rooms
    end

    def reserve_available_room(check_in, check_out)
      available_rooms = list_available_rooms(check_in, check_out)
      room = available_rooms.first

      return new_reservation(room.id, check_in, check_out)
    end

    def new_room_block(check_in, check_out, number_of_rooms, rate)
      new_room_block = RoomBlock.new(check_in, check_out, number_of_rooms, rate)
      @blocks << new_room_block
      return new_room_block
    end

  end
end
