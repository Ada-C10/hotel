require 'date'
require 'pry'

require_relative 'reservation'
require_relative 'room_block'
require_relative 'date_range'


module Hotel
  class ReservationHub
    class NoRoomsAvailableError < StandardError; end

    attr_reader :reservations, :room_bookings, :room_blocks


    def initialize
      @reservations = []
      @room_bookings = {1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [], 9 => [], 10 => [], 11 => [], 12 => [], 13 => [], 14 => [], 15 => [], 16 => [], 17 => [], 18 => [], 19 => [], 20 => []}
      @room_blocks = []
    end


    def add_reservation(start_date, end_date)

      dates = DateRange.new(start_date, end_date)
      reservation_dates = dates.create_date_array(start_date, end_date)

      room_id = assign_room(reservation_dates)

      reservation = Reservation.new(reservation_dates, room_id)

      @reservations << reservation

      return reservation
    end


    def add_room_block(start_date, end_date, total_rooms)

      dates = DateRange.new(start_date, end_date)
      reservation_dates = dates.create_date_array(start_date, end_date)

      room_ids = []

      total_rooms.times do
        room_id = assign_room(reservation_dates)
        room_ids << room_id
      end

      block_id = @room_blocks.length + 1

      room_block = RoomBlock.new(reservation_dates, room_ids, block_id)

      @room_blocks << room_block

      return room_block
    end


    def check_available_rooms(reservation_dates)

      available_rooms = []

      @room_bookings.each do |room, dates|
        overlap = reservation_dates & dates

        if overlap.length == 0
          available_rooms << room
        end

      end
      return available_rooms
    end


    def assign_room(reservation_dates)

      available_rooms = check_available_rooms(reservation_dates)

      if available_rooms == nil
        raise NoRoomsAvailableError, "No rooms are available."
      end

      room_id = available_rooms[0]

      reservation_dates.each{|date| @room_bookings[room_id] << date}

      return room_id
    end


    def find_reservations(date)

      reservations_by_date = []
      index = 0

      @reservations.each do

        if @reservations[index].reservation_dates.include?(date)
          reservations_by_date << @reservations[index]
        end
        index +=1

      end
      return reservations_by_date
    end


    def find_room_block(id)

      @room_blocks.each do |room_block|
        if room_block.block_id == id
          return room_block
        end
      end
    end

  end
end
