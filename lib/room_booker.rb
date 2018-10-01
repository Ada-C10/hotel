require 'date'
require_relative 'date_logic'
require_relative 'reservation'
require_relative 'room_block'
require_relative 'room_not_available'

module BookingLogic
  class RoomBooker
    Room = Struct.new(:id, :cost, :block_reserved)

    attr_reader :rooms
    attr_accessor :reservations, :blocks

    def initialize
      @rooms = populate_rooms
      @reservations = []
      @blocks = []
    end

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

    def list_reservations(date)
      list_of_reservations = []

      reservations.each do |reservation|
        if DateLogic.date_range_include?(reservation, date)
          list_of_reservations << reservation
        end
      end

      return list_of_reservations
    end

    def list_available_rooms(check_in, check_out)
      reserved_rooms = []

      reservations.each do |reservation|
        unless DateLogic.date_ranges_exclusive?(
          reservation.check_in,
          reservation.check_out,
          check_in,
          check_out
        )

          reserved_rooms << reservation.room
        end
      end

      unavailable_rooms = reserved_rooms + find_blocked_rooms(check_in, check_out)

      available_rooms = rooms.dup

      unavailable_rooms.each do |unavailable_room|
        available_rooms.delete_if { |room| room.id == unavailable_room.id }
      end

      return available_rooms
    end

    def new_reservation(room_id, check_in, check_out)
      room = find_room_by_id(room_id)
      room_unavailable?(room, check_in, check_out)
      new_reservation = BookingLogic::Reservation.new(room, check_in, check_out)
      reservations << new_reservation
      return new_reservation
    end

    def room_unavailable?(room, check_in, check_out)
      unless list_available_rooms(check_in, check_out).include?(room)
        raise RoomNotAvailable, "Room not available for the given dates"
      end
    end

    def find_block(name)
      found_block = blocks.find { |block| block.name == name }
      return found_block
    end

    def find_blocked_rooms(check_in, check_out)
      blocked_rooms = []

      blocks.each do |block|
        unless DateLogic::date_ranges_exclusive?(
          block.check_in,
          block.check_out,
          check_in,
          check_out
        )

          block.rooms.each do |room|
            blocked_rooms << room
          end
        end
      end

      return blocked_rooms
    end

    def block_available_rooms(check_in, check_out, number_of_rooms, rate)

      available_rooms = list_available_rooms(check_in, check_out)

      room_block = []

      number_of_rooms.times do |i|
        room_block << available_rooms[i].dup
      end

      if room_block.length < number_of_rooms
        raise StandardError, "There are not enough available rooms for the given dates to create this room block"
      end

      return room_block
    end

    def new_room_block(name, check_in, check_out, number_of_rooms, rate)

      block_of_rooms = block_available_rooms(
        check_in,
        check_out,
        number_of_rooms,
        rate
      )

      new_room_block = BookingLogic::RoomBlock.new(
        name,
        check_in,
        check_out,
        block_of_rooms,
        rate
      )

      new_room_block.set_blocked_room_rate

      @blocks << new_room_block
      return new_room_block
    end

    def new_block_reservation(name)
      block = find_block(name)
      room = block.reserve_room
      new_reservation = BookingLogic::Reservation.new(room, block.check_in, block.check_out)
      reservations << new_reservation
      return new_reservation
    end

    def set_room_rate(room_id, custom_rate)
      room = rooms.find { |room| room.id == room_id }
      room.cost = custom_rate
    end
  end
end
