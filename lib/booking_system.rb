require "date"

require_relative 'calendar'
require_relative 'reservation'
require_relative 'room_block'

module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations, :room_blocks

    def initialize()
      @rooms = list_all_rooms() #<-- array of all room numbeers
      @reservations = []
      @room_blocks = []
    end

    def list_all_rooms()
      return (1..20).to_a
    end

    def construct_cal_checker(check_in:, check_out:)
      return Calendar.new(check_in: check_in, check_out: check_out)
    end

    def generate_res_id()
      if @reservations.empty?
        return 1
      else
        return @reservations.max_by { |reservation| reservation.id}.id + 1
      end
    end

    def generate_block_id()
      if @room_blocks.empty?
        return 1
      else
        return @room_blocks.max_by { |block| block.id}.id + 1
      end
    end

    def list_res_for_date(check_date)
      matching_res = @reservations.select { |reservation| reservation.has_date?(check_date) }

      return matching_res.empty? ? nil : matching_res
    end

    def list_avail_rooms_for_range(check_in:, check_out:)
      date_range = construct_cal_checker(check_in: check_in, check_out: check_out)

        booked_rooms = @reservations.select { |reservation| reservation.overlap?(date_range) }.map { |reservation| reservation.room_num }

        avail_rooms = @rooms - booked_rooms

        held_rooms = @room_blocks.select { |block| block.overlap?(date_range) }.map {|block| block.rooms}

        if !held_rooms.empty?
          held_rooms = held_rooms[0] # list within a list
        end

        avail_rooms -= held_rooms

      return avail_rooms.empty? ? nil : avail_rooms
    end

    def create_reservation(check_in:, check_out:)
      id = generate_res_id() #<-- create new reservation id
      avail_rooms = list_avail_rooms_for_range(check_in: check_in, check_out: check_out) #<-- grab first available room

      if avail_rooms.nil?
        raise StandardError, "No rooms are available for the given date range: #{check_in} - #{check_out}."
      else
        avail_room = avail_rooms[0]
      end

      new_reservation = Hotel::Reservation.new(
        id: id,
        room_num: avail_room,
        check_in: check_in,
        check_out: check_out)

      @reservations << new_reservation

      return new_reservation
    end

    def create_room_block(check_in:, check_out:, block_size:)
      avail_rooms = list_avail_rooms_for_range(check_in: check_in, check_out: check_out)

      if avail_rooms.nil? || avail_rooms.length < block_size
        raise StandardError, "Not enough rooms are available for the given date range: #{check_in} - #{check_out}."
      else
        avail_room = avail_rooms[0]
      end

      hold_rooms = avail_rooms[0..block_size-1]
      id = generate_block_id()

      new_room_block = Hotel::RoomBlock.new(id: id, check_in: check_in, check_out: check_out, rooms: hold_rooms)

      @room_blocks << new_room_block
      return new_room_block
    end
  end
end
