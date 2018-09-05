require_relative 'hotel_helper'
require 'pry'

# class HotelManager retrieves and saves information about rooms and reservations
module Hotel
  class HotelManager
    attr_reader :rooms
    attr_accessor :reservations

    # As an administrator, I can access the list of all of the rooms in the hotel
    def initialize(room_file = 'support/rooms.csv',
                    reservations_file = 'support/reservations.csv')
      @rooms = load_rooms(room_file)
      @reservations = load_reservations(reservations_file)
    end

    # As an administrator, I can reserve a room for a given date range
    def reserve(room_number, check_in, check_out)
      new_reservation = Hotel::Reservation.new(room_number, check_in, check_out)

      room = rooms.find {|r| r.id == room_number}
      all_dates = date_array(check_in, check_out)
      all_dates.each do |date|
        room.status_by_date[date] = :UNAVAILABLE
      end
      reservations << new_reservation
    end

    # As an administrator, I can access the list of reservations for a specific date
    def find_reservations_by_date(date)
      found_reservations = []

      @reservations.each do |reservation|
        all_dates = date_array(reservation.check_in, reservation.check_out)
        if all_dates.include? Date.parse(date)
          found_reservations << reservation
        end
      end

      return found_reservations
    end

    # def available_rooms(check_in, check_out)
    #   date_array = *(Date.parse(check_in)...Date.parse(check_out))
    #
    #   @rooms.each do |room|
    #     date_array.each do |date|
    #       if room.calendar[date] == :UNAVAILABLE
    #         return nil
    #       end
    #     end
    #   end
    #
    #   return :AVAILABLE
    # end

    def load_rooms(filename)
      all_rooms = []
      room_data = CSV.open(filename, 'r', headers: true, header_converters: :symbol)

      room_data.each do |room|
        new_room = Room.new(room[:id].to_i)
        all_rooms << new_room
      end

      return all_rooms
    end

    def load_reservations(filename)
      all_reservations = []
      reservation_data = CSV.open(filename, 'r', headers: true, header_converters: :symbol)

      reservation_data.each do |reservation|
        new_reservation = Reservation.new(reservation[:room_number].to_i, reservation[:check_in], reservation[:check_out])
        all_reservations << new_reservation
      end

      #add reservations to rooms

      return all_reservations
    end

    private
    def date_array(start_date, end_date)
      all_dates = *(Date.parse(start_date)...Date.parse(end_date))
      return all_dates
    end
  end
end
