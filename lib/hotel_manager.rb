require_relative 'hotel_helper'

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

    # As an administrator, I can reserve an available room for a given date range
    def reserve(room_number, check_in, check_out)
      availability = Room.is_available?(rooms, room_number, check_in, check_out)

      if availability
        new_reservation = Reservation.new(room_number, check_in, check_out)

        Room.change_status_of_room(rooms, room_number, check_in, check_out)

        reservations << new_reservation
      else
        raise StandardError.new("Room is not available for the given date range.")
      end
    end

    # As an administrator, I can access the list of reservations for a specific date
    def find_reservations(date)
      found_reservations = []

      reservations.each do |reservation|
        all_dates = DateRange.create_date_array(reservation.check_in, reservation.check_out)
        if all_dates.include? Date.parse(date)
          found_reservations << reservation
        end
      end

      return found_reservations
    end

    # As an administrator, I can view a list of rooms that are not reserved for a given date range
    def find_available_rooms(rooms, start_date, end_date)
      return Calendar.available_rooms(rooms, start_date, end_date)
    end

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
        Room.change_status_of_room(rooms, reservation[:room_number].to_i, reservation[:check_in], reservation[:check_out])
        all_reservations << new_reservation
      end

      return all_reservations
    end

  end
end
