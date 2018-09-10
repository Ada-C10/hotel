require_relative 'reservation_creator'
require 'pry'

module Hotel
  class BookingSystem < ReservationCreator
    attr_reader :num_of_rooms, :reservations, :list_of_reservations

    def initialize
      @reservations = {}
      @num_of_rooms = 20
      @list_of_reservations = []
    end

    def any_rooms(date)
      if @reservations[date] == nil
        @reservations[date] = {}
        return true
      elsif @reservations[date].keys.length < @num_of_rooms
        return true
      else
        return false
      end
    end

    def reserve_room(date, room_number)
      if @reservations[date] == nil
        @reservations[date] = {}
      end
      if @reservations[date][room_number] == true
        return false
      end

      @reservations[date][room_number] = true
      # ouput = {180904=>{0=>true}

      return true
    end

    def reserve_room_for_date_range(check_in_date:, check_out_date:)
      space = can_make_reservation(check_in_date: check_in_date, check_out_date: check_out_date)
      if space == true

        available_room = show_available_rooms_in_range(check_in_date: check_in_date, check_out_date: check_out_date).first
        date = check_in_date

        while date != check_out_date
          reserved = reserve_room(date, available_room)
          date += 1
        end
      else
        raise ArgumentError, "there are no more rooms"
      end

      reservation = ReservationCreator.new(check_in_date: check_in_date, check_out_date: check_out_date, room_number: available_room)
      @list_of_reservations << reservation
    end

    def automatically_reserve_and_return_room_number(date)
      room_number = 1
      room_reserved = reserve_room(date, room_number)
      if room_reserved == true
        return room_number
      end

      while room_reserved == false
        room_number += 1
        if room_number > @num_of_rooms
          raise ArgumentError, "unavailable room"
        end

        room_reserved = reserve_room(date, room_number)
      end

      return room_number
    end

    def can_make_reservation(check_in_date:, check_out_date:)

      date = check_in_date

      while date != check_out_date
        if any_rooms(date) == false
          return false
        else
          date += 1
        end
      end


      return true
    end

    def show_reserved_rooms(date)
      if @reservations[date] == nil
        return []
      end

      return @reservations[date].keys
    end

    def show_available_rooms_in_range(check_in_date:, check_out_date:)
      rooms = [*1..@num_of_rooms]
      # rooms = rooms + group2
      date = check_in_date

      while date != check_out_date
        rooms += show_reserved_rooms(date)
          date += 1
          # binding.pry
      end

      return rooms.find_all {|room| rooms.count(room) == 1}
    end

    def list_reservations_by_date(date)
      specific_date = Date.parse("#{date}")

      bookings_by_date = []
      @list_of_reservations.each do |booking|
        dates = booking.date_range
        if dates.include?(specific_date)
          bookings_by_date << booking
        end
      end

      return bookings_by_date
    end

    def list_all_rooms
      return [*1..@num_of_rooms]
    end
  end
end
