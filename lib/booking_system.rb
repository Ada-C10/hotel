require_relative 'date_range'
require_relative 'reservation'
require 'pry'

module Hotel
  class BookingSystem
    attr_reader :reservations, :rooms

    VALID_ROOM_NUMBERS = (1..20)
    ROOM_COST = 200
    DISCOUNT_ROOM_RATE = 150

    def initialize
      @reservations = []
      @rooms = VALID_ROOM_NUMBERS
    end


    ####
    # room: an Integer for the room number
    # check_in: a Date object for the check in day
    # check_out: a Date object for the check out day
    def book_room(room_number, check_in, check_out)
      unless VALID_ROOM_NUMBERS.include?(room_number)
        raise ArgumentError
      end

      date_range = Hotel::DateRange.new(check_in, check_out)

      unless available_rooms(date_range).include?(room_number)
        raise ArgumentError
      end

      new_reservation = Hotel::Reservation.new(room_number, ROOM_COST, date_range)

      @reservations << new_reservation
      return new_reservation
    end

    def reservations_on_date(date)
      reservations = []
      @reservations.each do |reservation|
        if reservation.within_reservation?(date)
          reservations << reservation
        end
      end
      return reservations
    end

    def available_rooms(date_range)
      # made a copy of the rooms array
      rooms = @rooms.to_a

      # iterating through date ranges, at each reservation, removing the room
      # that is reserved by that reservation
      (date_range.start_date...date_range.end_date).each do |date|
        self.reservations_on_date(date).each do |reservation|
          rooms.delete(reservation.room_number)
        end
      end
      # returns the list of available_rooms
      return rooms
    end

    def create_room_block(number_of_rooms, check_in, check_out)

      date_range = Hotel::DateRange.new(check_in, check_out)

      rooms = self.available_rooms(date_range)

      unless rooms.length >= number_of_rooms
        raise StandardError
      end

      


    end


  end
end
